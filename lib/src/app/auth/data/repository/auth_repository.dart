import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:skribla/env/env.dart';
import 'package:skribla/src/app/auth/data/models/user_model.dart';
import 'package:skribla/src/core/resource/firebase_paths.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/util/enums.dart';
import 'package:skribla/src/core/util/result.dart';

/// Repository class for managing auth-related data operations.
///
/// It interacts with Firebase services (Authentication and Firestore) to
/// perform these operations.
///
/// It also utilizes [AppLocalizations] to localize the error messages.
///
/// Key methods:
/// - [signInAnonymously]: Signs in the user anonymously.
/// - [signInWithProvider]: Signs in the user with a specified authentication provider.
/// - [saveAnonymousUser]: Saves an anonymous user to Firestore.
/// - [getUser]: Gets the user from Firestore.
/// - [updateUserName]: Updates the user's name in Firestore.
/// - [deleteAccount]: Deletes the user's account from Firestore and Firebase Authentication.

final class AuthRepository {
  const AuthRepository({
    required this.loc,
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });
  static const _logger = Logger('AuthRepository');

  final AppLocalizations loc;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  /// Signs in the user anonymously.
  ///
  /// This method attempts to sign in the user anonymously using Firebase Authentication.
  /// If the sign-in is successful, it checks if the user is new. If the user is new,
  /// it saves the user to Firestore. If the user is not new, it retrieves the existing user.
  ///
  /// Returns a [Result] containing a [UserModel] if the sign-in is successful, or an error if it fails.
  Future<Result<UserModel>> signInAnonymously() async {
    try {
      _logger.request('Signing in anonymously');
      final userCredential = await firebaseAuth.signInAnonymously();

      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        return await saveAnonymousUser(userCredential);
      } else {
        return await getUser();
      }
    } catch (e, s) {
      _logger.error('signInAnonymously - $e', stack: s);
      return Result.error(CustomError(message: loc.signinErr));
    }
  }

  /// Signs in the user with a specified authentication provider.
  ///
  /// This method attempts to sign in the user using the specified [AuthOptions] provider.
  /// It supports signing in with Apple and Google providers. If the user is already signed in
  /// anonymously, it links the new credential to the existing user. If the credential is already
  /// in use, it signs in the existing user.
  ///
  /// [option] The authentication provider to use for signing in.
  ///
  /// Returns a [Result] containing a [UserModel] if the sign-in is successful, or an error if it fails.
  Future<Result<UserModel>> signInWithProvider(AuthOptions option) async {
    try {
      _logger.request('Signing in with ${option.name}');

      OAuthCredential credential;
      switch (option) {
        case AuthOptions.apple:
          final appleUser = await SignInWithApple.getAppleIDCredential(
            scopes: [AppleIDAuthorizationScopes.email],
          );

          credential = OAuthProvider('apple.com').credential(
            accessToken: appleUser.authorizationCode,
            idToken: appleUser.identityToken,
          );
        case AuthOptions.google:
          final googleUser = await GoogleSignIn(
            clientId: kIsWeb ? Env.gIdClientIdWWeb : null,
            scopes: ['email'],
          ).signIn();

          if (googleUser == null) {
            return Result.error(CustomError(message: loc.authFailedErr));
          }
          final googleAuth = await googleUser.authentication;

          credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
      }
      UserCredential userCredential;
      try {
        _logger.request('Linking credential for anonymous user');
        userCredential = await firebaseAuth.currentUser!.linkWithCredential(credential);
      } on FirebaseAuthException catch (e, s) {
        _logger.error('linkWithCredential - $e', stack: s);
        switch (e.code) {
          case 'provider-already-linked':
          case 'credential-already-in-use':
          case 'email-already-in-use':
            _logger.info('Signing in existing user - ${e.code}');
            userCredential = await firebaseAuth.signInWithCredential(credential);
          default:
            return Result.error(CustomError(message: loc.authFailedErr));
        }
      }

      await firebaseFirestore
          .collection(FirebasePaths.users)
          .doc(firebaseAuth.currentUser!.uid)
          .update({
        'status': UserStatus.verified.name,
        'email': userCredential.user?.email ?? '',
      });

      return await getUser();
    } catch (e, s) {
      _logger.error('signInWithProvider - $e', stack: s);
      return Result.error(CustomError(message: loc.createAccountErr));
    }
  }

  /// Saves an anonymous user to Firestore after successful sign-in.
  ///
  /// This method is called after a successful anonymous sign-in to save the user's
  /// data to Firestore. It creates a new document in the 'users' collection with
  /// the user's ID and a default display name.
  ///
  /// [userCredential] The credential of the user signed in anonymously.
  ///
  /// Returns a [Result] containing the saved [UserModel] or an error if the operation fails.
  Future<Result<UserModel>> saveAnonymousUser(UserCredential userCredential) async {
    try {
      _logger.request('Saving anonymous user - ${userCredential.user}');

      final user = UserModel.fromCredential(userCredential);
      await firebaseFirestore.collection(FirebasePaths.users).doc(user.uid).set(user.toJson());

      return Result.success(user);
    } catch (e, s) {
      _logger.error('saveAnonumousUser - $e', stack: s);
      return Result.error(CustomError(message: loc.saveUserErr));
    }
  }

  /// Retrieves the user from Firestore based on the user's ID.
  ///
  /// This method fetches the user's data from Firestore based on their ID and
  /// returns a [UserModel] object.
  ///
  /// [uid] The ID of the user to retrieve.
  ///
  /// Returns a [Result] containing the retrieved [UserModel] or an error if the operation fails.
  Future<Result<UserModel>> getUser([String? uid]) async {
    try {
      _logger.request('Getting user${uid != null ? ' - $uid' : ''}');

      final doc = await firebaseFirestore
          .collection('users')
          .doc(uid ?? firebaseAuth.currentUser?.uid)
          .get();
      if (!doc.exists) {
        _logger.info('getUser - User not found');
        return const Result.error(CustomError(message: 'User not found'));
      }
      final user = UserModel.fromJson(doc.data()!);

      return Result.success(user);
    } catch (e, s) {
      _logger.error('getUser - $e', stack: s);
      return Result.error(CustomError(message: loc.getUserErr));
    }
  }

  /// Updates the user's name in Firestore.
  ///
  /// This method updates the user's name in Firestore based on the current user's ID.
  ///
  /// [name] The new name of the user.
  ///
  /// Returns a [Result] containing a boolean value indicating the success of the operation or an error if the operation fails.
  Future<Result<bool>> updateUserName(String name) async {
    try {
      _logger.request('Updating user name - $name');

      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({'name': name});

      return const Result.success(true);
    } catch (e, s) {
      _logger.error('updateUserName - $e', stack: s);
      return Result.error(CustomError(message: loc.updateUserErr));
    }
  }

  /// This method deletes the user's account from Firestore and Firebase Authentication.
  ///
  /// It first updates the user's document in Firestore to mark the account as deleted,
  /// and then deletes the user's account from Firebase Authentication.
  ///
  /// Returns a [Result] containing a boolean value indicating the success of the operation or an error if the operation fails.
  Future<Result<bool>> deleteAccount() async {
    try {
      _logger.request('Deleting user');
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({'name': 'Deleted', 'email': '', 'status': UserStatus.anonymous.name});

      await firebaseAuth.currentUser!.delete();
      return const Result.success(true);
    } on FirebaseAuthException catch (e, s) {
      _logger.error('deleteAccount - ${e.code}', stack: s);
      switch (e.code) {
        case 'requires-recent-login':
          return _reauthenticateAndDelete();
        default:
          return Result.error(CustomError(message: loc.accountDeletionFailedErr));
      }
    } catch (e, s) {
      _logger.error('deleteAccount - $e', stack: s);
      return Result.error(CustomError(message: loc.deleteAccountErr));
    }
  }

  /// This method reauthenticates the user and then deletes the user's account from Firebase Authentication.
  ///
  /// It first reauthenticates the user using the current provider, and then deletes the user's account.
  ///
  /// Returns a [Result] containing a boolean value indicating the success of the operation or an error if the operation fails.
  Future<Result<bool>> _reauthenticateAndDelete() async {
    try {
      _logger.request('Reauthenticating user');
      final providerData = firebaseAuth.currentUser?.providerData.first;

      if (AppleAuthProvider().providerId == providerData!.providerId) {
        await firebaseAuth.currentUser!.reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await firebaseAuth.currentUser!.reauthenticateWithProvider(GoogleAuthProvider());
      }

      await firebaseAuth.currentUser!.delete();
      return const Result.success(true);
    } catch (e, s) {
      _logger.error('_reauthenticateAndDelete - $e', stack: s);
      return Result.error(CustomError(message: loc.deleteAccountErr));
    }
  }
}

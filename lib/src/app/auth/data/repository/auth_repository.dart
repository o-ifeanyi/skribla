import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_and_guess/src/app/auth/data/models/user_model.dart';
import 'package:draw_and_guess/src/core/service/logger.dart';
import 'package:draw_and_guess/src/core/util/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AuthOptions { apple, google }

final class AuthRepository {
  const AuthRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });
  static const _logger = Logger('AuthRepository');

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

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
      return Result.error(CustomError(message: e.toString()));
    }
  }

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
            scopes: ['email'],
          ).signIn();
          if (googleUser == null) {
            return const Result.error(
              CustomError(message: 'Authenticataion failed'),
            );
          }
          final googleAuth = await googleUser.authentication;

          credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
      }

      try {
        _logger.request('Linking credential for anonymous user');
        await firebaseAuth.currentUser!.linkWithCredential(credential);
      } on FirebaseAuthException catch (e, s) {
        _logger.error('linkWithCredential - $e', stack: s);
        switch (e.code) {
          case 'provider-already-linked':
          case 'credential-already-in-use':
          case 'email-already-in-use':
            _logger.info('Signing in existing user - ${e.code}');
            await firebaseAuth.signInWithCredential(credential);
          default:
            return Result.error(CustomError(message: e.toString()));
        }
      }

      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({'status': AuthStatus.verified.name});

      return await getUser();
    } catch (e, s) {
      _logger.error('signInWithProvider - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

  Future<Result<UserModel>> saveAnonymousUser(UserCredential userCredential) async {
    try {
      _logger.request('Saving anonymous user - ${userCredential.user}');

      final user = UserModel.fromCredential(userCredential);
      await firebaseFirestore.collection('users').doc(user.uid).set(user.toJson());

      return Result.success(user);
    } catch (e, s) {
      _logger.error('saveAnonumousUser - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

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
      return Result.error(CustomError(message: e.toString()));
    }
  }

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
      return Result.error(CustomError(message: e.toString()));
    }
  }

  Future<Result<bool>> deleteAccount() async {
    try {
      _logger.request('Deleting user');
      await firebaseAuth.currentUser!.delete();
      return const Result.success(true);
    } catch (e, s) {
      _logger.error('deleteAccount - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/auth/data/models/user_model.dart';
import 'package:skribla/src/app/home/data/repository/home_repository.dart';
import 'package:skribla/src/app/home/presentation/provider/home_state.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/service/toast.dart';

/// A provider class that manages the home screen state and operations.
///
/// This class extends [StateNotifier] and is responsible for handling
/// game-related actions such as creating, finding, and joining games.
/// It also manages the state of the home screen and interacts with the
/// [HomeRepository] to perform these operations.
///
/// The [HomeProvider] uses [HomeState] to represent the current state
/// of the home screen, including the status of ongoing operations.
///
/// Key responsibilities:
/// - Creating new games
/// - Finding existing games
/// - Joining games by ID
/// - Updating the user's name if necessary
/// - Managing the home screen state
/// - Handling errors and displaying toast messages
///
/// This provider is typically used in conjunction with Riverpod to
/// manage the state and logic of the home screen in the application.

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider({
    required this.ref,
    required this.toast,
    required this.homeRepository,
  }) : super(const HomeState());

  final Ref ref;
  final Toast toast;
  final HomeRepository homeRepository;

  Future<void> _updateUserNameIfNeeded(UserModel user) async {
    if (user.name != ref.read(authProvider).user?.name) {
      await ref.read(authProvider.notifier).updateUserName(user.name);
    }
  }

  Future<String?> createGame(UserModel user) async {
    state = state.copyWith(status: HomeStatus.creatingGame);
    await _updateUserNameIfNeeded(user);
    final res = await homeRepository.createGame(user);
    state = state.copyWith(status: HomeStatus.idle);
    return res.when(
      success: (id) => id,
      error: (error) {
        toast.showError(error.message);
        return null;
      },
    );
  }

  Future<String?> findGame(UserModel user) async {
    state = state.copyWith(status: HomeStatus.findingGame);
    await _updateUserNameIfNeeded(user);
    final res = await homeRepository.findGame(user);
    state = state.copyWith(status: HomeStatus.idle);
    return res.when(
      success: (id) => id,
      error: (error) {
        toast.showError(error.message);
        return null;
      },
    );
  }

  Future<String?> joinGame({required String id, required UserModel user}) async {
    state = state.copyWith(status: HomeStatus.joiningGame);
    await _updateUserNameIfNeeded(user);
    final res = await homeRepository.joinGame(id: id, user: user);
    state = state.copyWith(status: HomeStatus.idle);
    return res.when(
      success: (id) => id,
      error: (error) {
        toast.showError(error.message);
        return null;
      },
    );
  }
}

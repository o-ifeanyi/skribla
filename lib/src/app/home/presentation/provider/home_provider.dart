import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/auth/data/models/user_model.dart';
import 'package:skribla/src/app/home/data/repository/home_repository.dart';
import 'package:skribla/src/app/home/presentation/provider/home_state.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/service/toast.dart';

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider({
    required this.ref,
    required this.toast,
    required this.homeRepository,
  }) : super(const HomeState());

  final Ref ref;
  final Toast toast;
  final HomeRepository homeRepository;

  Future<String?> createGame(UserModel user) async {
    state = state.copyWith(status: HomeStatus.creatingGame);
    if (user.name != ref.read(authProvider).user?.name) {
      await ref.read(authProvider.notifier).updateUserName(user.name);
    }
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
    if (user.name != ref.read(authProvider).user?.name) {
      await ref.read(authProvider.notifier).updateUserName(user.name);
    }
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
    if (user.name != ref.read(authProvider).user?.name) {
      await ref.read(authProvider.notifier).updateUserName(user.name);
    }
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

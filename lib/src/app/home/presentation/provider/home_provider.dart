import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/auth/data/models/user_model.dart';
import 'package:skribla/src/app/home/data/repository/home_repository.dart';
import 'package:skribla/src/app/home/presentation/provider/home_state.dart';

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider({required this.homeRepository}) : super(const HomeState());

  final HomeRepository homeRepository;

  Future<String?> createGame(UserModel user) async {
    state = state.copyWith(status: HomeStatus.creatingGame);
    final res = await homeRepository.createGame(user);
    state = state.copyWith(status: HomeStatus.idle);
    return res.when(
      success: (id) => id,
      error: (error) => null,
    );
  }

  Future<String?> findGame(UserModel user) async {
    state = state.copyWith(status: HomeStatus.findingGame);
    final res = await homeRepository.findGame(user);
    state = state.copyWith(status: HomeStatus.idle);
    return res.when(
      success: (id) => id,
      error: (error) => null,
    );
  }

  Future<String?> joinGame({required String id, required UserModel user}) async {
    state = state.copyWith(status: HomeStatus.joiningGame);
    final res = await homeRepository.joinGame(id: id, user: user);
    state = state.copyWith(status: HomeStatus.idle);
    return res.when(
      success: (id) => id,
      error: (error) => null,
    );
  }
}

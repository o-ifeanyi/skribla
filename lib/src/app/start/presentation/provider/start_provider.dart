import 'package:draw_and_guess/src/app/auth/data/models/user_model.dart';
import 'package:draw_and_guess/src/app/start/data/repository/start_repository.dart';
import 'package:draw_and_guess/src/app/start/presentation/provider/start_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartProvider extends StateNotifier<StartState> {
  StartProvider({required this.startRepository}) : super(const StartState());

  final StartRepository startRepository;

  Future<String?> findGame(UserModel user) async {
    state = state.copyWith(status: StartStatus.findingGame);
    final res = await startRepository.findGame(user);
    state = state.copyWith(status: StartStatus.idle);
    return res.when(
      success: (id) => id,
      error: (error) => null,
    );
  }
}

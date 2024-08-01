import 'package:draw_and_guess/src/app/leaderboard/data/models/leaderboard_model.dart';
import 'package:draw_and_guess/src/app/leaderboard/data/repository/leaderboard_repository.dart';
import 'package:draw_and_guess/src/app/leaderboard/presentation/provider/leaderboard_state.dart';
import 'package:draw_and_guess/src/core/util/types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaderboardProvider extends StateNotifier<LeaderboardState> {
  LeaderboardProvider({required this.leaderboardRepository}) : super(const LeaderboardState());

  final LeaderboardRepository leaderboardRepository;

  final _leaderboardSize = 10;

  Future<void> getLeaderboard({
    required LeaderboardController controller,
    LeaderboardModel? lastItem,
  }) async {
    final isFirstPage = controller.firstPageKey == null;
    final res = await leaderboardRepository.getLeaderboard(
      type: state.type,
      pageSize: _leaderboardSize,
      lastItem: lastItem,
    );
    res.when(
      success: (data) {
        if (isFirstPage) {
          state = state.copyWith(topThree: data.take(3).toList());
        }
        final isLastPage = data.length < _leaderboardSize;
        if (isLastPage) {
          controller.appendLastPage(isFirstPage ? data.skip(3).toList() : data);
        } else {
          controller.appendPage(data, data.lastOrNull);
        }
      },
      error: (error) {
        controller.error = error;
      },
    );
  }

  void switchType(int index) {
    state = switch (index) {
      0 => state.copyWith(type: LeaderboardType.monthly),
      _ => state.copyWith(type: LeaderboardType.alltime),
    };
  }

  Future<LeaderboardPosition> getLeaderboardPosition() async =>
      leaderboardRepository.getLeaderboardPosition(state.type);
}

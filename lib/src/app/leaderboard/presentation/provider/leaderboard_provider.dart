import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/leaderboard/data/models/leaderboard_model.dart';
import 'package:skribla/src/app/leaderboard/data/repository/leaderboard_repository.dart';
import 'package:skribla/src/app/leaderboard/presentation/provider/leaderboard_state.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/util/enums.dart';
import 'package:skribla/src/core/util/types.dart';

/// A provider class for managing leaderboard-related state and operations.
///
/// This class extends [StateNotifier] and manages the state of type [LeaderboardState].
/// It provides functionality to fetch leaderboard data, handle pagination, and switch between leaderboard types.
///
/// The class interacts with [LeaderboardRepository] to retrieve leaderboard data
/// and implements methods for managing the leaderboard view.
///
/// Key features:
/// - Fetches paginated leaderboard data
/// - Manages the state of leaderboard data loading
/// - Provides functionality to switch between monthly and all-time leaderboard types
/// - Handles different behavior for anonymous and verified users
///
/// Usage:
/// This provider is typically used in conjunction with Riverpod to manage
/// the state of the leaderboard feature in the application.

class LeaderboardProvider extends StateNotifier<LeaderboardState> {
  LeaderboardProvider({
    required this.ref,
    required this.leaderboardRepository,
  }) : super(const LeaderboardState());

  final Ref ref;
  final LeaderboardRepository leaderboardRepository;

  final _leaderboardSize = 10;

  Future<void> getLeaderboard({
    required LeaderboardController controller,
    LeaderboardModel? lastItem,
  }) async {
    final res = await leaderboardRepository.getLeaderboard(
      type: state.type,
      pageSize: _leaderboardSize,
      lastItem: lastItem,
    );
    res.when(
      success: (data) {
        final isFirstPage = lastItem == null;
        final isAnonymousUser = ref.read(authProvider).user?.status == UserStatus.anonymous;
        if (isFirstPage) {
          state = state.copyWith(topThree: data.take(3).toList());
        }
        // only fetch max of 20 iems for anonymous users and 100 items for verified users
        final maxFetchAmount = isAnonymousUser ? 20 : 100;
        final isLastPage = data.length < _leaderboardSize ||
            (controller.itemList ?? []).length + data.length >= maxFetchAmount;
        final leaderboard = isFirstPage ? data.skip(3).toList() : data;
        if (isLastPage) {
          controller.appendLastPage(leaderboard);
        } else {
          controller.appendPage(leaderboard, leaderboard.lastOrNull);
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

  Future<LeaderboardPosition?> getLeaderboardPosition() async {
    final user = ref.read(authProvider).user;
    if (user?.status != UserStatus.verified) return null;
    return leaderboardRepository.getLeaderboardPosition(state.type);
  }
}

import 'package:draw_and_guess/src/app/game/data/models/game_model.dart';
import 'package:draw_and_guess/src/app/leaderboard/data/models/leaderboard_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef CachedData<T> = ({T data, DateTime expiry});
typedef HistoryController = PagingController<GameModel?, GameModel>;
typedef LeaderboardController = PagingController<LeaderboardModel?, LeaderboardModel>;
typedef LeaderboardPosition = ({int position, LeaderboardModel model});

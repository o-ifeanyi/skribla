import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skribla/src/app/game/data/models/game_model.dart';
import 'package:skribla/src/app/leaderboard/data/models/leaderboard_model.dart';

typedef CachedData<T> = ({T data, DateTime expiry});
typedef HistoryController = PagingController<GameModel?, GameModel>;
typedef LeaderboardController = PagingController<LeaderboardModel?, LeaderboardModel>;
typedef LeaderboardPosition = ({int position, LeaderboardModel model});

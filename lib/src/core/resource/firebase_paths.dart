import 'package:skribla/src/app/leaderboard/data/repository/leaderboard_repository.dart';

abstract class FirebasePaths {
  static const String users = 'users';
  static const String games = 'games';
  static const String words = 'words';
  static String exhibits(String id) => 'games/$id/exhibits';
  static String messages(String id) => 'games/$id/messages';
  static String leaderboard(LeaderboardType type) => 'leaderboard/${type.name}/users';
}

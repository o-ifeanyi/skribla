import 'package:skribla/src/core/util/enums.dart';

abstract class FirebasePaths {
  static const String users = 'users';
  static const String games = 'games';
  static const String words = 'words';
  static const String reports = 'reports';
  static String exhibits(String id) => 'games/$id/exhibits';
  static String messages(String id) => 'games/$id/messages';
  static String leaderboard(LeaderboardType type) => 'leaderboard/${type.name}/users';
}

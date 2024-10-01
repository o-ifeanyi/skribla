enum UserStatus { suspended, anonymous, verified }

enum AuthOptions { apple, google }

enum GameStatus { open, private, closed, complete }

enum TimerType { cool, skip, turn, complete, idle }

enum LeaderboardType { monthly, alltime }

enum LeaderboardStatus { idle, gettingUserPosition }

enum ButtonType { filled, outlined, elevated, text }

enum PageType { grid, list }

enum SafetyOption { report, block, unknown }

enum ErrorReason {
  unknown('unknown'),
  noPoints('No points on the board');

  const ErrorReason(this.value);
  final String value;
}

enum Event {
  appOpen('app_open'),
  playGame('play_game'),
  createGame('create_game'),
  joinGame('join_game'),
  copyLink('copy_link'),
  viewLeaderboard('view_leaderboard'),
  viewHistory('view_history'),
  viewSettings('view_settings'),
  shareArt('share_art'),
  gameEnd('game_end'),
  signUp('sign_up');

  const Event(this.value);
  final String value;
}

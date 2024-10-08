import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skribla/src/app/auth/data/repository/auth_repository.dart';
import 'package:skribla/src/app/auth/presentation/provider/auth_provider.dart';
import 'package:skribla/src/app/auth/presentation/provider/auth_state.dart';
import 'package:skribla/src/app/game/data/repository/game_repository.dart';
import 'package:skribla/src/app/game/presentation/provider/game_provider.dart';
import 'package:skribla/src/app/game/presentation/provider/game_state.dart';
import 'package:skribla/src/app/game/presentation/provider/timer_provider.dart';
import 'package:skribla/src/app/game/presentation/provider/timer_state.dart';
import 'package:skribla/src/app/history/data/repository/history_repository.dart';
import 'package:skribla/src/app/history/presentation/provider/history_provider.dart';
import 'package:skribla/src/app/history/presentation/provider/history_state.dart';
import 'package:skribla/src/app/home/data/repository/home_repository.dart';
import 'package:skribla/src/app/home/presentation/provider/home_provider.dart';
import 'package:skribla/src/app/home/presentation/provider/home_state.dart';
import 'package:skribla/src/app/leaderboard/data/repository/leaderboard_repository.dart';
import 'package:skribla/src/app/leaderboard/presentation/provider/leaderboard_provider.dart';
import 'package:skribla/src/app/leaderboard/presentation/provider/leaderboard_state.dart';
import 'package:skribla/src/app/settings/data/repository/settings_repository.dart';
import 'package:skribla/src/app/settings/presentation/provider/loc_provider.dart';
import 'package:skribla/src/app/settings/presentation/provider/settings_provider.dart';
import 'package:skribla/src/app/settings/presentation/provider/settings_state.dart';
import 'package:skribla/src/core/service/toast.dart';

// Providers
final authProvider = StateNotifierProvider<AuthProvider, AuthState>(
  (ref) => AuthProvider(
    toast: Toast.instance,
    authRepository: ref.read(authRepoProvider),
  ),
);

final homeProvider = StateNotifierProvider<HomeProvider, HomeState>(
  (ref) => HomeProvider(
    ref: ref,
    toast: Toast.instance,
    homeRepository: ref.read(homeRepoProvider),
  ),
);

final timerProvider = StateNotifierProvider<TimerProvider, TimerState>(
  (ref) => TimerProvider(),
);

final gameProvider = StateNotifierProvider<GameProvider, GameState>(
  (ref) => GameProvider(
    ref: ref,
    toast: Toast.instance,
    gameRepository: ref.read(gameRepoProvider),
  ),
);

final historyProvider = StateNotifierProvider<HistoryProvider, HistoryState>(
  (ref) => HistoryProvider(
    galleryRepository: ref.read(galleryRepoProvider),
  ),
);

final leaderboardProvider = StateNotifierProvider<LeaderboardProvider, LeaderboardState>(
  (ref) => LeaderboardProvider(
    ref: ref,
    leaderboardRepository: ref.read(leaderboardRepoProvider),
  ),
);

final settingsProvider = StateNotifierProvider<SettingsProvider, SettingsState>(
  (ref) => SettingsProvider(
    sharedPreferences: ref.read(sharedPreferencedProvider).value,
    settingsRepository: ref.read(settingsRepoProvider),
  ),
);

// Repositories
final authRepoProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    loc: ref.read(locProvider),
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

final homeRepoProvider = Provider<HomeRepository>(
  (ref) => HomeRepository(
    loc: ref.read(locProvider),
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

final gameRepoProvider = Provider<GameRepository>(
  (ref) => GameRepository(
    loc: ref.read(locProvider),
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    leaderboardRepository: ref.read(leaderboardRepoProvider),
  ),
);

final galleryRepoProvider = Provider<HistoryRepository>(
  (ref) => HistoryRepository(
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

final leaderboardRepoProvider = Provider<LeaderboardRepository>(
  (ref) => LeaderboardRepository(
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

final settingsRepoProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

// Externals
final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (_) => FirebaseFirestore.instance,
);

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (_) => FirebaseAuth.instance,
);

final sharedPreferencedProvider = FutureProvider<SharedPreferences>((_) {
  return SharedPreferences.getInstance();
});

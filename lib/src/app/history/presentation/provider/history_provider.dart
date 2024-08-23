import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/game/data/models/game_model.dart';
import 'package:skribla/src/app/history/data/repository/history_repository.dart';
import 'package:skribla/src/app/history/presentation/provider/history_state.dart';
import 'package:skribla/src/core/platform/others.dart'
    if (dart.library.html) 'package:skribla/src/core/platform/web.dart' as platform;
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/types.dart';

/// A provider class for managing history-related state and operations.
///
/// This class extends [StateNotifier] and manages the state of type [HistoryState].
/// It provides functionality to fetch game history, handle pagination, and share images.
///
/// The class interacts with [HistoryRepository] to retrieve game history data
/// and implements methods for sharing screenshots of the history view.
///
/// Key features:
/// - Fetches paginated game history
/// - Manages the state of history data loading and sharing
/// - Provides functionality to share screenshots of the history view
///
/// Usage:
/// This provider is typically used in conjunction with Riverpod to manage
/// the state of the history feature in the application.

class HistoryProvider extends StateNotifier<HistoryState> {
  HistoryProvider({
    required this.galleryRepository,
  }) : super(const HistoryState());

  final HistoryRepository galleryRepository;

  final _historySize = 10;

  Future<void> getHistory({
    required HistoryController controller,
    GameModel? lastItem,
  }) async {
    final res = await galleryRepository.getHistory(
      pageSize: _historySize,
      lastItem: lastItem,
    );
    res.when(
      success: (data) {
        final isLastPage = data.length < _historySize;
        if (isLastPage) {
          controller.appendLastPage(data);
        } else {
          controller.appendPage(data, data.lastOrNull);
        }
      },
      error: (error) {
        controller.error = error;
      },
    );
  }

  Future<void> shareImage(GlobalKey screenshotKey) async {
    try {
      state = state.copyWith(sharing: true);
      await Future<void>.delayed(Config.duration300);

      final render = screenshotKey.currentContext?.findRenderObject();
      final image = await (render as RenderRepaintBoundary?)?.toImage();

      if (image == null) return;
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData == null) return;

      final fileName = 'screenshot-${DateTime.now().microsecondsSinceEpoch}.png';

      await platform.shareImage(byteData, fileName);
    } catch (error) {
      Logger.log(error);
    } finally {
      state = state.copyWith(sharing: false);
    }
  }
}

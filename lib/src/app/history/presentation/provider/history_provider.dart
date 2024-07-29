import 'package:draw_and_guess/src/app/game/data/models/game_model.dart';
import 'package:draw_and_guess/src/app/history/data/models/exhibit_model.dart';
import 'package:draw_and_guess/src/app/history/data/repository/history_repository.dart';
import 'package:draw_and_guess/src/app/history/presentation/provider/history_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef HistoryController = PagingController<GameModel?, GameModel>;

class HistoryProvider extends StateNotifier<HistoryState> {
  HistoryProvider({
    required this.galleryRepository,
  }) : super(const HistoryState());

  final HistoryRepository galleryRepository;

  final _historySize = 10;

  Future<void> getHistory(
    GameModel? lastItem,
    HistoryController controller,
  ) async {
    final res = await galleryRepository.getHistory(
      pageSize: _historySize,
      lastItem: lastItem,
    );
    res.when(
      success: (data) {
        final isLastPage = data.length < 10;
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

  Future<List<ExhibitModel>> getExhibits(String id) async => galleryRepository.getExhibits(id);
}

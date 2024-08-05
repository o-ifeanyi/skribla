import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skribla/src/core/widgets/error_widget.dart';

enum PageType { grid, list }

class PagedWidget<T> extends StatelessWidget {
  const PagedWidget({
    required this.pageType,
    required this.pagingController,
    required this.itemBuilder,
    super.key,
    this.gridDelegate,
    this.padding,
    this.listSeperator,
    this.firstPageErrorIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.topSpacer,
  });
  final PageType pageType;
  final PagingController<dynamic, T> pagingController;
  final ItemWidgetBuilder<T> itemBuilder;
  final SliverGridDelegate? gridDelegate;
  final EdgeInsetsGeometry? padding;
  final Widget? listSeperator;
  final Widget Function(BuildContext)? firstPageErrorIndicatorBuilder;
  final Widget Function(BuildContext)? newPageErrorIndicatorBuilder;
  final Widget Function(BuildContext)? noItemsFoundIndicatorBuilder;
  final Widget Function(BuildContext)? noMoreItemsIndicatorBuilder;
  final Widget Function(BuildContext)? firstPageProgressIndicatorBuilder;
  final double? topSpacer;

  @override
  Widget build(BuildContext context) {
    final errorPage = ErrorWidget(
      topSpacer: topSpacer,
      retry: pagingController.refresh,
    );

    return switch (pageType) {
      PageType.list => PagedListView.separated(
          pagingController: pagingController,
          separatorBuilder: (_, __) => listSeperator ?? const SizedBox.shrink(),
          padding: padding,
          builderDelegate: PagedChildBuilderDelegate<T>(
            animateTransitions: true,
            itemBuilder: itemBuilder,
            firstPageErrorIndicatorBuilder: (_) => errorPage,
            firstPageProgressIndicatorBuilder: firstPageProgressIndicatorBuilder ??
                (_) => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
            newPageErrorIndicatorBuilder: newPageErrorIndicatorBuilder,
            newPageProgressIndicatorBuilder: (_) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
            noMoreItemsIndicatorBuilder: noMoreItemsIndicatorBuilder,
          ),
        ),
      PageType.grid => PagedGridView(
          pagingController: pagingController,
          gridDelegate: gridDelegate ??
              const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 550,
                mainAxisExtent: 180,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
          padding: padding,
          builderDelegate: PagedChildBuilderDelegate<T>(
            animateTransitions: true,
            itemBuilder: itemBuilder,
            firstPageErrorIndicatorBuilder: (_) => errorPage,
            firstPageProgressIndicatorBuilder: firstPageProgressIndicatorBuilder ??
                (_) => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
            newPageErrorIndicatorBuilder: newPageErrorIndicatorBuilder,
            newPageProgressIndicatorBuilder: (_) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
            noMoreItemsIndicatorBuilder: noMoreItemsIndicatorBuilder,
          ),
        )
    };
  }
}

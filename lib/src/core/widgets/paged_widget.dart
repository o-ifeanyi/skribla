import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
    final errorPage = Column(
      children: [
        SizedBox(height: topSpacer ?? Config.height * 0.3),
        Text(
          'Something went wrong',
          style: context.textTheme.titleSmall,
        ),
        Config.vBox12,
        const Text(
          'Try again or contact us at drawandguesseng@gmail.com',
          textAlign: TextAlign.center,
        ),
        Config.vBox12,
        AppButton(
          text: 'Retry',
          onPressed: pagingController.refresh,
        ),
      ],
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

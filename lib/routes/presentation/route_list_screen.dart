import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/routes/presentation/widgets/route_filter_bar.dart';
import 'package:free_beta/routes/presentation/widgets/route_list.dart';

class RouteListScreen extends ConsumerWidget {
  static Route<dynamic> route({
    required AutoDisposeFutureProvider<RouteFilterModel> routeProvider,
    required AutoDisposeFutureProvider<List<RouteModel>> refreshProvider,
    AppBar? appBar,
  }) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return RouteListScreen(
        routeProvider: routeProvider,
        refreshProvider: refreshProvider,
        appBar: appBar,
      );
    });
  }

  const RouteListScreen({
    Key? key,
    required this.routeProvider,
    required this.refreshProvider,
    this.appBar,
  }) : super(key: key);

  final AutoDisposeFutureProvider<RouteFilterModel> routeProvider;
  final AutoDisposeFutureProvider<List<RouteModel>> refreshProvider;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: Key('route-list-screen'),
      appBar: appBar,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: NestedScrollView(
          controller:
              ref.watch(routeListScrollControllerProvider).scrollController,
          headerSliverBuilder: (_, __) => [
            SliverPersistentHeader(
              delegate: RouteFilterBar(routeProvider: routeProvider),
              pinned: true,
            ),
          ],
          body: _RouteListBody(
            routeProvider: routeProvider,
            refreshProvider: refreshProvider,
          ),
        ),
      ),
    );
  }
}

class _RouteListBody extends ConsumerWidget {
  const _RouteListBody({
    Key? key,
    required this.routeProvider,
    required this.refreshProvider,
  }) : super(key: key);

  final AutoDisposeFutureProvider<RouteFilterModel> routeProvider;
  final AutoDisposeFutureProvider<List<RouteModel>> refreshProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(routeProvider).when(
          data: (routeFilterModel) => RouteList(
            scrollKey: 'route-list',
            routes: routeFilterModel.filteredRoutes.sortRoutes(),
            onRefresh: () => _refreshRoutes(ref),
          ),
          error: (error, stackTrace) => _ErrorList(
            onRefresh: () => _refreshRoutes(ref),
            error: error,
            stackTrace: stackTrace,
          ),
          loading: () => _LoadingList(),
        );
  }

  Future<void> _refreshRoutes(WidgetRef ref) async {
    ref.invalidate(refreshProvider);
  }
}

class _ErrorList extends ConsumerWidget {
  const _ErrorList({
    Key? key,
    required this.onRefresh,
    required this.error,
    required this.stackTrace,
  }) : super(key: key);

  final VoidCallback onRefresh;
  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(crashlyticsApiProvider).logError(
          error,
          stackTrace,
          'RouteListScreen',
          'routeProvider',
        );

    return ErrorCard(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(FreeBetaColors.black),
        ),
        onPressed: onRefresh,
        child: Text(
          'Try again',
          style: FreeBetaTextStyle.h4.copyWith(
            color: FreeBetaColors.white,
          ),
        ),
      ),
    );
  }
}

class _LoadingList extends StatelessWidget {
  const _LoadingList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FreeBetaPadding.xxlVertical,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

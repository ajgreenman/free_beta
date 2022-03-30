import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/presentation/widgets/route_filter_bar.dart';
import 'package:free_beta/routes/presentation/widgets/route_list.dart';

class RouteListScreen extends ConsumerStatefulWidget {
  static Route<dynamic> route({
    required FutureProvider<RouteFilterModel> routeProvider,
    required FutureProvider<List<RouteModel>> refreshProvider,
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

  final FutureProvider<RouteFilterModel> routeProvider;
  final FutureProvider<List<RouteModel>> refreshProvider;
  final AppBar? appBar;

  @override
  _RouteListScreenState createState() => _RouteListScreenState();
}

class _RouteListScreenState extends ConsumerState<RouteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('route-list-screen'),
      appBar: widget.appBar,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RouteFilterBar(
              routeProvider: widget.routeProvider,
            ),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ref.watch(widget.routeProvider).when(
          data: (routeFilterModel) => RouteList(
            routes: routeFilterModel.filteredRoutes.sortRoutes(),
            onRefresh: _refreshRoutes,
          ),
          error: (error, stackTrace) => _onError(error, stackTrace),
          loading: () => _onLoading(),
        );
  }

  Widget _onError(Object? error, StackTrace? stackTrace) {
    return ErrorCard(
      error: error,
      stackTrace: stackTrace,
      child: ElevatedButton(
        onPressed: _refreshRoutes,
        child: Text('Try again'),
      ),
    );
  }

  Widget _onLoading() {
    return Padding(
      padding: FreeBetaPadding.xxlVertical,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _refreshRoutes() async {
    ref.refresh(widget.refreshProvider);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/presentation/widgets/route_list.dart';

class RouteListScreen extends ConsumerStatefulWidget {
  static Route<dynamic> route({
    required FutureProvider<RouteFilterModel> routeProvider,
    AppBar? appBar,
  }) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return RouteListScreen(
        routeProvider: routeProvider,
        appBar: appBar,
      );
    });
  }

  const RouteListScreen({
    Key? key,
    required this.routeProvider,
    this.appBar,
  }) : super(key: key);

  final FutureProvider<RouteFilterModel> routeProvider;
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
            Padding(
              padding: FreeBetaPadding.mAll,
              child: _buildFilterText(context),
            ),
            _buildFilterCounts(),
            Divider(height: 1, thickness: 1),
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

  Widget _buildFilterCounts() {
    var routeFilterModel =
        ref.watch(widget.routeProvider).whenOrNull(data: (value) => value);

    if (routeFilterModel == null ||
        (routeFilterModel.filter?.isEmpty ?? true)) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: FreeBetaSizes.m,
        bottom: FreeBetaSizes.m,
      ),
      child: Text(
        'Showing ${routeFilterModel.filteredRoutes.length} ' +
            'of ${routeFilterModel.routes.length}',
      ),
    );
  }

  Widget _buildFilterText(BuildContext context) {
    var routeFilterText = ref.watch(routeTextFilterProvider);
    return TextFormField(
      initialValue: routeFilterText,
      onChanged: (value) {
        ref.read(routeTextFilterProvider.notifier).state = value;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(FreeBetaSizes.xl),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: FreeBetaSizes.ml,
        ),
        hintStyle: FreeBetaTextStyle.h4.copyWith(
          color: FreeBetaColors.grayLight,
        ),
        hintText: 'Type to filter routes',
      ),
      style: FreeBetaTextStyle.h4,
    );
  }

  Future<void> _refreshRoutes() async {
    ref.refresh(widget.routeProvider);
  }
}

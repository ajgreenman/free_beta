import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/error_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_card.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/presentation/route_detail_screen.dart';

class RouteListScreen extends ConsumerStatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return RouteListScreen();
    });
  }

  const RouteListScreen({Key? key}) : super(key: key);

  @override
  _RouteListScreenState createState() => _RouteListScreenState();
}

class _RouteListScreenState extends ConsumerState<RouteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('route-list'),
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
    return ref.watch(fetchTextFilteredRoutesProvider).when(
          data: (routeFilterModel) => _onSuccess(
            routeFilterModel.filteredRoutes.sortRoutes(),
          ),
          error: (error, stackTrace) => _onError(error, stackTrace),
          loading: () => _onLoading(),
        );
  }

  Widget _onSuccess(List<RouteModel> routes) {
    if (routes.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: FreeBetaSizes.l),
          child: Text(
            'Sorry, no available routes',
            style: FreeBetaTextStyle.h3,
          ),
        ),
      );
    }

    return Expanded(
      child: RefreshIndicator(
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () => Navigator.of(context).push(
                RouteDetailScreen.route(routes[index]),
              ),
              child: RouteCard(route: routes[index]),
            );
          },
          separatorBuilder: (_, __) => Divider(height: 1, thickness: 1),
          itemCount: routes.length,
        ),
        onRefresh: _refreshRoutes,
      ),
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
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildFilterCounts() {
    var routeFilterModel = ref
        .watch(fetchTextFilteredRoutesProvider)
        .whenOrNull(data: (value) => value);

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

  Future<List<RouteModel>> _refreshRoutes() async {
    ref.refresh(fetchRoutesProvider);
    return ref.read(fetchRoutesProvider.future);
  }
}

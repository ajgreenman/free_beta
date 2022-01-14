import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
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
      appBar: AppBar(
        title: Text('Elev8'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: FreeBetaSizes.xxl,
            color: FreeBetaColors.white,
          ),
        ),
      ),
      body: ref.watch(fetchRoutesProvider).when(
            data: (routes) => _onSuccess(context, routes.sortRoutes()),
            error: (error, stacktrace) => _onError(),
            loading: () => _onLoading(),
          ),
    );
  }

  Widget _onSuccess(BuildContext context, List<RouteModel> routes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: FreeBetaPadding.lAll,
          child: _buildFilterRow(context),
        ),
        _buildRouteList(routes),
      ],
    );
  }

  Widget _onError() {
    return Text('Sorry, an error occured.');
  }

  Widget _onLoading() {
    return CircularProgressIndicator();
  }

  Widget _buildFilterRow(BuildContext context) {
    final routeColorFilter = ref.watch(routeColorFilterProvider);
    final routeTypeFilter = ref.watch(routeTypeFilterProvider);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Filter by Type',
                style: FreeBetaTextStyle.h3,
              ),
            ),
            _buildDropDown<ClimbType>(
              _getClimbTypes(),
              (value) {
                ref.read(routeTypeFilterProvider.notifier).state = value;
              },
              routeTypeFilter,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Filter by Color',
                style: FreeBetaTextStyle.h3,
              ),
            ),
            _buildDropDown<RouteColor?>(
              _getColors(),
              (value) {
                ref.read(routeColorFilterProvider.notifier).state = value;
              },
              routeColorFilter,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropDown<T>(
    List<DropdownMenuItem<T?>> items,
    void Function(T?) onChanged,
    T? value,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: FreeBetaPadding.mAll,
      child: DropdownButtonFormField<T?>(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FreeBetaColors.blueDark,
                width: 2.0,
              ),
            ),
            contentPadding: FreeBetaPadding.mAll),
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: FreeBetaSizes.xxl,
          color: FreeBetaColors.blueDark,
        ),
        value: value,
        items: items,
        onChanged: onChanged,
      ),
    );
  }

  List<DropdownMenuItem<ClimbType?>> _getClimbTypes() {
    var climbTypeItems = ClimbType.values
        .map(
          (climbType) => DropdownMenuItem<ClimbType?>(
            value: climbType,
            child: Text(climbType.displayName),
          ),
        )
        .toList();

    climbTypeItems.insert(
      0,
      DropdownMenuItem<ClimbType?>(
        value: null,
        child: Text('Any'),
      ),
    );

    return climbTypeItems;
  }

  List<DropdownMenuItem<RouteColor?>> _getColors() {
    var colorItems = RouteColor.values
        .map(
          (routeColor) => DropdownMenuItem<RouteColor?>(
            value: routeColor,
            child: Text(routeColor.displayName),
          ),
        )
        .toList();

    colorItems.insert(
      0,
      DropdownMenuItem<RouteColor?>(
        value: null,
        child: Text('Any'),
      ),
    );

    return colorItems;
  }

  Widget _buildRouteList(List<RouteModel> routes) {
    if (routes.isEmpty) {
      return Center(
        child: Text(
          'Sorry, no available routes',
          style: FreeBetaTextStyle.h3,
        ),
      );
    }

    return Expanded(
      child: Padding(
        padding: FreeBetaPadding.mAll,
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
      ),
    );
  }
}

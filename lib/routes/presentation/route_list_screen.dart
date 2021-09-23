import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/presentation/route_card.dart';
import 'package:free_beta/routes/cubit/route_cubit.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/cubit/route_state.dart';
import 'package:free_beta/routes/presentation/route_color_icon.dart';
import 'package:free_beta/routes/presentation/route_detail_screen.dart';

class RouteListScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return RouteListScreen();
    });
  }

  const RouteListScreen({Key? key}) : super(key: key);

  @override
  _RouteListScreenState createState() => _RouteListScreenState();
}

class _RouteListScreenState extends State<RouteListScreen> {
  int? _currentTypeFilter;
  int? _currentColorFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('free-beta-home'),
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
      body: BlocBuilder<RouteCubit, RouteState>(
        builder: (_, state) => state.routes.maybeWhen(
          success: (routes) => _onSuccess(context, routes.sortRoutes()),
          error: (_, __) => _onError(),
          loading: () => CircularProgressIndicator(),
          orElse: () => SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _onSuccess(BuildContext context, List<RouteModel> routes) {
    var filteredRoutes = _filterRoutes(routes);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: FreeBetaPadding.lAll,
          child: _buildFilterRow(context),
        ),
        _buildRouteList(filteredRoutes),
      ],
    );
  }

  Widget _buildFilterRow(BuildContext context) {
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
            _buildDropDown(
              context,
              _currentTypeFilter,
              _getClimbTypes(),
              (value) => setState(() {
                _currentTypeFilter = value;
              }),
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
            _buildDropDown(
              context,
              _currentColorFilter,
              _getColors(),
              (value) => setState(() {
                _currentColorFilter = value;
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropDown(
    BuildContext context,
    int? value,
    List<DropdownMenuItem<int?>> items,
    void Function(int?) onChanged,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: FreeBetaPadding.mAll,
      child: DropdownButtonFormField<int?>(
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

  Widget _onError() {
    return Text('Sorry, an error occured.');
  }

  List<DropdownMenuItem<int?>> _getClimbTypes() {
    var climbTypeItems = ClimbType.values
        .map(
          (climbType) => DropdownMenuItem<int?>(
            value: climbType.index,
            child: Text(climbType.displayName),
          ),
        )
        .toList();

    climbTypeItems.insert(
      0,
      DropdownMenuItem<int?>(
        value: null,
        child: Text('Any'),
      ),
    );

    return climbTypeItems;
  }

  List<DropdownMenuItem<int?>> _getColors() {
    var colorItems = RouteColor.values
        .map(
          (routeColor) => DropdownMenuItem<int?>(
            value: routeColor.index,
            child: Text(routeColor.displayName),
          ),
        )
        .toList();

    colorItems.insert(
      0,
      DropdownMenuItem<int?>(
        value: null,
        child: Text('Any'),
      ),
    );

    return colorItems;
  }

  List<RouteModel> _filterRoutes(List<RouteModel> routes) {
    var filteredRoutes = routes;
    if (_currentTypeFilter != null) {
      filteredRoutes = filteredRoutes
          .where((route) => route.climbType.index == _currentTypeFilter)
          .toList();
    }
    if (_currentColorFilter != null) {
      filteredRoutes = filteredRoutes
          .where((route) => route.routeColor.index == _currentColorFilter)
          .toList();
    }
    return filteredRoutes;
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
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () => Navigator.of(context)
                .push(RouteDetailScreen.route(routes[index])),
            child: RouteCard(route: routes[index]),
          );
        },
        separatorBuilder: (_, __) => Divider(height: 1, thickness: 1),
        itemCount: routes.length,
      ),
    );
  }
}

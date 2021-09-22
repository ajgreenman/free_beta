import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/presentation/route_card.dart';
import 'package:free_beta/routes/cubit/route_cubit.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/cubit/route_state.dart';

class FreeBeta extends StatefulWidget {
  const FreeBeta({Key? key}) : super(key: key);

  @override
  _FreeBetaState createState() => _FreeBetaState();
}

class _FreeBetaState extends State<FreeBeta> {
  int? _currentTypeFilter;
  int? _currentColorFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('free-beta-home'),
      appBar: AppBar(
        title: Text('Elev8'),
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
        _buildFilterRow(context),
        ..._buildRouteList(filteredRoutes),
      ],
    );
  }

  Widget _buildFilterRow(BuildContext context) {
    return Column(
      children: [
        _buildDropDown(
          context,
          _currentTypeFilter,
          _getClimbTypes(),
          (value) => setState(() {
            _currentTypeFilter = value;
          }),
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
        child: Text('Filter by Type'),
      ),
    );

    return climbTypeItems;
  }

  List<DropdownMenuItem<int?>> _getColors() {
    var colorItems = RouteColor.values
        .map(
          (colorItems) => DropdownMenuItem<int?>(
            value: colorItems.index,
            child: Text(colorItems.displayName),
          ),
        )
        .toList();

    colorItems.insert(
      0,
      DropdownMenuItem<int?>(
        value: null,
        child: Text('Filter by Color'),
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

  List<Widget> _buildRouteList(List<RouteModel> routes) {
    if (routes.isEmpty) {
      return [
        Text('Sorry, no available routes'),
      ];
    }

    return [
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: FreeBetaSizes.m),
            child: Text('Color'),
          ),
          Expanded(child: Text('Difficulty')),
          Expanded(child: Text('Type')),
        ],
      ),
      Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, index) => RouteCard(route: routes[index]),
          separatorBuilder: (_, __) => Divider(height: 1, thickness: 1),
          itemCount: routes.length,
        ),
      ),
    ];
  }
}

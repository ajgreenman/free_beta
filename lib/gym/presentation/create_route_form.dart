import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/presentation/route_color_square.dart';

class CreateRouteForm extends StatefulWidget {
  const CreateRouteForm({Key? key}) : super(key: key);

  @override
  _CreateRouteFormState createState() => _CreateRouteFormState();
}

class _CreateRouteFormState extends State<CreateRouteForm> {
  RouteFormModel _formModel = RouteFormModel();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: FreeBetaPadding.mAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextForm(
              'Name',
              (name) => _formModel.name = name,
            ),
            _buildDropdown<RouteColor?>(
              'Color',
              _getColors(),
              (routeColor) => _formModel.routeColor = routeColor,
            ),
            _buildDropdown<ClimbType?>(
              'Type',
              _getTypes(),
              (climbType) => _formModel.climbType = climbType,
            ),
            _buildTextForm(
              'Difficulty',
              (difficulty) => _formModel.difficulty = difficulty,
            ),
            ElevatedButton(
              onPressed: _onCreate,
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextForm(String label, Function(String?) onSaved) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Text(
                    label,
                    style: FreeBetaTextStyle.h4,
                  ),
                  Spacer(),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: TextFormField(
                onSaved: onSaved,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FreeBetaColors.blueDark,
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FreeBetaColors.blueDark,
                      width: 2.0,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: FreeBetaSizes.m),
                ),
                style: FreeBetaTextStyle.h4,
              ),
            ),
          ],
        ),
        SizedBox(height: FreeBetaSizes.m),
      ],
    );
  }

  Widget _buildDropdown<T>(
    String label,
    List<DropdownMenuItem<T?>> items,
    void Function(T?) onChanged,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Text(
                    label,
                    style: FreeBetaTextStyle.h4,
                  ),
                  Spacer(),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: DropdownButtonFormField<T?>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FreeBetaColors.blueDark,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: FreeBetaPadding.mAll,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: FreeBetaSizes.xxl,
                  color: FreeBetaColors.blueDark,
                ),
                items: items,
                onChanged: onChanged,
                style: FreeBetaTextStyle.h4,
              ),
            ),
          ],
        ),
        SizedBox(height: FreeBetaSizes.m),
      ],
    );
  }

  Future<void> _onCreate() async {
    log(_formModel.toString());
  }

  List<DropdownMenuItem<RouteColor?>> _getColors() => RouteColor.values
      .map(
        (routeColor) => DropdownMenuItem<RouteColor?>(
          value: routeColor,
          child: Row(
            children: [
              Text(routeColor.displayName),
              Padding(
                padding: const EdgeInsets.only(
                  left: FreeBetaSizes.m,
                ),
                child: RouteColorSquare(routeColor: routeColor),
              ),
            ],
          ),
        ),
      )
      .toList();

  List<DropdownMenuItem<ClimbType?>> _getTypes() => ClimbType.values
      .map(
        (climbType) => DropdownMenuItem<ClimbType?>(
          value: climbType,
          child: Text(climbType.displayName),
        ),
      )
      .toList();
}

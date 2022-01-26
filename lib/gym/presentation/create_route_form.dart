import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_color_square.dart';
import 'package:intl/intl.dart';

class CreateRouteForm extends ConsumerStatefulWidget {
  const CreateRouteForm({Key? key}) : super(key: key);

  @override
  _CreateRouteFormState createState() => _CreateRouteFormState();
}

class _CreateRouteFormState extends ConsumerState<CreateRouteForm> {
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
            _buildDate(
              context,
              'Creation Date',
            ),
            ElevatedButton(
              onPressed: _onCreate,
              child: Text('Create Route'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextForm(String label, Function(String?) onChanged) {
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
                onChanged: onChanged,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: FreeBetaSizes.m,
                  ),
                  hintStyle: FreeBetaTextStyle.h4.copyWith(
                    color: FreeBetaColors.grayLight,
                  ),
                  hintText: 'Enter ${label.toLowerCase()}',
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
                      width: 2.0,
                    ),
                  ),
                  contentPadding: FreeBetaPadding.mAll,
                  hintStyle: FreeBetaTextStyle.h4.copyWith(
                    color: FreeBetaColors.grayLight,
                  ),
                  hintText: 'Enter ${label.toLowerCase()}',
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

  Widget _buildDate(
    BuildContext context,
    String label,
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
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: MaterialStateProperty.all(
                      FreeBetaColors.white,
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
                        width: 2,
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: FreeBetaSizes.m,
                        vertical: FreeBetaSizes.ml,
                      ),
                    ),
                  ),
                  child: _buildDateLabel(label, _formModel.creationDate),
                  onPressed: () async {
                    var pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _formModel.creationDate ?? DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime.now(),
                    );
                    setState(() {
                      _formModel.creationDate = pickedDate;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: FreeBetaSizes.m),
      ],
    );
  }

  Future<void> _onCreate() async {
    await ref.read(routeApiProvider).addRoute(_formModel);
  }

  Widget _buildDateLabel(String fieldName, DateTime? date) {
    if (date == null) {
      return Text(
        'Enter ${fieldName.toLowerCase()}',
        style: FreeBetaTextStyle.h4.copyWith(
          color: FreeBetaColors.grayLight,
        ),
      );
    }

    return Text(
      DateFormat('MM/dd').format(date),
      style: FreeBetaTextStyle.h4,
    );
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

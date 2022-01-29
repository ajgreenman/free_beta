import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/image_api.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _nameController = TextEditingController();
  final _difficultyController = TextEditingController();
  final _dateController = TextEditingController();
  final _imageController = TextEditingController();

  var _loadingImages = false;
  var _formModel = RouteFormModel();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: FreeBetaPadding.mAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextForm(
                'Name',
                (name) => _formModel.name = name,
                _nameController,
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
                _difficultyController,
              ),
              _buildButtonForm(
                'Creation Date',
                'Enter creation date',
                _onDatePressed,
                _dateController,
              ),
              _buildButtonForm(
                'Images',
                'Add images (${_formModel.images.length})',
                _onImagePressed,
                _imageController,
                isImageField: true,
              ),
              _buildCreateRouteButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextForm(
    String label,
    Function(String?) onChanged,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FreeBetaTextStyle.h3,
        ),
        SizedBox(height: FreeBetaSizes.m),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label is required';
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FreeBetaColors.red,
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
        SizedBox(height: FreeBetaSizes.l),
      ],
    );
  }

  Widget _buildDropdown<T>(
    String label,
    List<DropdownMenuItem<T?>> items,
    void Function(T?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FreeBetaTextStyle.h3,
        ),
        SizedBox(height: FreeBetaSizes.m),
        DropdownButtonFormField<T?>(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FreeBetaColors.red,
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
          validator: (value) {
            if (value == null) {
              return '$label is required';
            }
          },
          style: FreeBetaTextStyle.h4,
        ),
        SizedBox(height: FreeBetaSizes.l),
      ],
    );
  }

  Widget _buildButtonForm(
    String label,
    String hintText,
    Function() onTap,
    TextEditingController controller, {
    bool isImageField = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FreeBetaTextStyle.h3,
        ),
        SizedBox(height: FreeBetaSizes.m),
        TextFormField(
          controller: controller,
          onTap: onTap,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label is required';
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FreeBetaColors.red,
                width: 2.0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: FreeBetaSizes.m,
            ),
            hintStyle: FreeBetaTextStyle.h4.copyWith(
              color: FreeBetaColors.grayLight,
            ),
            hintText: isImageField && _loadingImages ? 'Loading...' : hintText,
          ),
          style: FreeBetaTextStyle.h4,
        ),
        SizedBox(height: FreeBetaSizes.l),
      ],
    );
  }

  Widget _buildCreateRouteButton(BuildContext context) => ElevatedButton(
        onPressed:
            !_loadingImages ? () async => _onCreateFormPressed(context) : null,
        child: Padding(
          padding: FreeBetaPadding.xlHorizontal,
          child: Text(
            'Create Route',
            style: FreeBetaTextStyle.h4.copyWith(
              color: FreeBetaColors.white,
            ),
          ),
        ),
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
          side: MaterialStateProperty.resolveWith<BorderSide>((states) {
            if (states.contains(MaterialState.disabled)) {
              return BorderSide(
                color: FreeBetaColors.grayLight,
                width: 2,
              );
            }
            return BorderSide(
              width: 2,
            );
          }),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: FreeBetaSizes.m,
              vertical: FreeBetaSizes.ml,
            ),
          ),
        ),
      );

  Future<void> _onDatePressed() async {
    FocusScope.of(context).requestFocus(FocusNode());

    var pickedDate = await showDatePicker(
      context: context,
      initialDate: _formModel.creationDate ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) return;

    setState(() {
      _formModel.creationDate = pickedDate;
      _dateController.value = TextEditingValue(
        text: DateFormat('MM/dd').format(pickedDate),
      );
    });
  }

  Future<void> _onImagePressed() async {
    setState(() {
      _loadingImages = true;
    });

    FocusScope.of(context).requestFocus(FocusNode());

    var imageApi = ref.read(imageApiProvider);
    var imageFile = await imageApi.fetchImage();

    setState(() {
      _loadingImages = false;
    });

    if (imageFile == null) return;

    setState(() {
      _formModel.images.add(imageFile);
      _imageController.value = TextEditingValue(
        text: 'Add images (${_formModel.images.length})',
      );
    });
  }

  Future<void> _onCreateFormPressed(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    await ref.read(routeApiProvider).addRoute(_formModel);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Route created!'),
            Spacer(),
            Icon(Icons.check),
          ],
        ),
      ),
    );
    Navigator.of(context).pop();
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

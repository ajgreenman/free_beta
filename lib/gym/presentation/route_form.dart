import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/image_api.dart';
import 'package:free_beta/app/presentation/widgets/form/button_input.dart';
import 'package:free_beta/app/presentation/widgets/form/dropdown_list.dart';
import 'package:free_beta/app/presentation/widgets/form/text_input.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_color_square.dart';
import 'package:intl/intl.dart';

class RouteForm extends ConsumerStatefulWidget {
  const RouteForm({Key? key, this.editRouteModel}) : super(key: key);

  final RouteModel? editRouteModel;

  @override
  _RouteFormState createState() => _RouteFormState();
}

class _RouteFormState extends ConsumerState<RouteForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _nameController;
  late TextEditingController _difficultyController;
  late TextEditingController _creationDateController;
  late TextEditingController _removalDateController;
  late TextEditingController _imageController;

  var _loadingImages = false;
  late RouteFormModel _formModel;

  @override
  void initState() {
    super.initState();

    if (widget.editRouteModel != null) {
      _setupEdit();
    } else {
      _setupCreate();
    }
  }

  void _setupEdit() {
    var routeModel = widget.editRouteModel!;
    _formModel = RouteFormModel.fromRouteModel(
      routeModel,
    );
    _nameController = TextEditingController(
      text: routeModel.name,
    );
    _difficultyController = TextEditingController(
      text: routeModel.difficulty,
    );
    _creationDateController = TextEditingController(
      text: DateFormat('MM/dd').format(routeModel.creationDate),
    );
    _removalDateController = TextEditingController(
      text: routeModel.removalDate != null
          ? DateFormat('MM/dd').format(routeModel.removalDate!)
          : '',
    );
    _imageController = TextEditingController(
      text: _imageHintText,
    );
  }

  void _setupCreate() {
    _formModel = RouteFormModel();
    _nameController = TextEditingController();
    _difficultyController = TextEditingController();
    _creationDateController = TextEditingController();
    _removalDateController = TextEditingController();
    _imageController = TextEditingController();
  }

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
              FreeBetaTextInput(
                label: 'Name',
                onChanged: (name) => _formModel.name = name,
                controller: _nameController,
                skipValidation: true,
              ),
              FreeBetaDropdownList<RouteColor?>(
                label: 'Color',
                items: _getColors(),
                onChanged: (routeColor) => _formModel.routeColor = routeColor,
                initialValue: widget.editRouteModel?.routeColor,
              ),
              FreeBetaDropdownList<ClimbType?>(
                label: 'Type',
                items: _getTypes(),
                onChanged: (climbType) => _formModel.climbType = climbType,
                initialValue: widget.editRouteModel?.climbType,
              ),
              FreeBetaTextInput(
                label: 'Difficulty',
                onChanged: (difficulty) => _formModel.difficulty = difficulty,
                controller: _difficultyController,
              ),
              FreeBetaButtonInput(
                label: 'Creation Date',
                hintText: 'Enter creation date',
                onTap: _onCreationDatePressed,
                controller: _creationDateController,
              ),
              if (widget.editRouteModel != null)
                FreeBetaButtonInput(
                  label: 'Removal Date',
                  hintText: 'Enter removal date',
                  onTap: _onRemovalDatePressed,
                  controller: _removalDateController,
                  isRequired: false,
                ),
              FreeBetaButtonInput(
                label: 'Images',
                hintText: _imageHintText,
                onTap: _onImagePressed,
                controller: _imageController,
                isImageField: true,
              ),
              widget.editRouteModel == null
                  ? _buildCreateRouteButton(context)
                  : _buildEditRouteButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateRouteButton(BuildContext context) => ElevatedButton(
        onPressed:
            !_loadingImages ? () async => _onCreateRoutePressed(context) : null,
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

  Future<void> _onCreateRoutePressed(BuildContext context) async {
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

  Widget _buildEditRouteButton(BuildContext context) => ElevatedButton(
        onPressed:
            !_loadingImages ? () async => _onEditRoutePressed(context) : null,
        child: Padding(
          padding: FreeBetaPadding.xlHorizontal,
          child: Text(
            'Update Route',
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

  Future<void> _onEditRoutePressed(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    await ref.read(routeApiProvider).updateRoute(
          widget.editRouteModel!,
          _formModel,
        );
    ref.refresh(fetchRoutesProvider);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Route updated!'),
            Spacer(),
            Icon(Icons.check),
          ],
        ),
      ),
    );
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Future<void> _onCreationDatePressed() async {
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
      _creationDateController.value = TextEditingValue(
        text: DateFormat('MM/dd').format(pickedDate),
      );
    });
  }

  Future<void> _onRemovalDatePressed() async {
    FocusScope.of(context).requestFocus(FocusNode());

    var pickedDate = await showDatePicker(
      context: context,
      initialDate: _formModel.removalDate ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) return;

    setState(() {
      _formModel.removalDate = pickedDate;
      _removalDateController.value = TextEditingValue(
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
      if (_formModel.images == null) {
        _formModel.images = [];
      }
      _formModel.images!.add(imageFile);
      _imageController.value = TextEditingValue(
        text: 'Add images (${_formModel.images!.length})',
      );
    });
  }

  List<DropdownMenuItem<RouteColor?>> _getColors() => RouteColor.values
      .map(
        (routeColor) => DropdownMenuItem<RouteColor?>(
          value: routeColor,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: FreeBetaSizes.m,
                ),
                child: RouteColorSquare(routeColor: routeColor),
              ),
              Text(routeColor.displayName),
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

  String get _imageHintText {
    if (_loadingImages) {
      return 'Loading...';
    }
    if (_formModel.images != null && _formModel.images!.length > 0) {
      return 'Add more images (${_formModel.images!.length})';
    }
    return 'Add images (0)';
  }
}

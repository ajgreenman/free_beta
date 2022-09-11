import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/media_api.dart';
import 'package:free_beta/app/presentation/widgets/form/button_input.dart';
import 'package:free_beta/app/presentation/widgets/form/dropdown_list.dart';
import 'package:free_beta/app/presentation/widgets/form/text_input.dart';
import 'package:free_beta/app/presentation/widgets/form/wall_section_input.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_color_square.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RouteForm extends ConsumerStatefulWidget {
  const RouteForm({
    Key? key,
    this.editRouteModel,
    required this.setDirtyForm,
  }) : super(key: key);

  final RouteModel? editRouteModel;
  final VoidCallback setDirtyForm;

  @override
  _RouteFormState createState() => _RouteFormState();
}

class _RouteFormState extends ConsumerState<RouteForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _nameController;
  late TextEditingController _creationDateController;
  late TextEditingController _removalDateController;
  late TextEditingController _imageController;
  late TextEditingController _betaVideoController;

  var _loadingImages = false;
  var _loadingBetaVideo = false;
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
    _betaVideoController = TextEditingController(
      text: _betaVideoHintText,
    );
  }

  void _setupCreate() {
    _formModel = RouteFormModel();
    _nameController = TextEditingController();
    _creationDateController = TextEditingController();
    _removalDateController = TextEditingController();
    _imageController = TextEditingController();
    _betaVideoController = TextEditingController();
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
                onChanged: (name) {
                  if (name != null && name != _formModel.name) {
                    widget.setDirtyForm();
                  }
                  return _formModel.name = name;
                },
                controller: _nameController,
                skipValidation: true,
              ),
              FreeBetaButtonInput(
                label: 'Images',
                hintText: _imageHintText,
                onTap: () => _onImagePressed(context),
                controller: _imageController,
              ),
              FreeBetaButtonInput(
                label: 'Beta Video',
                hintText: _betaVideoHintText,
                onTap: () => _onBetaVideoPressed(context),
                controller: _betaVideoController,
                isRequired: false,
              ),
              FreeBetaDropdownList<WallLocation?>(
                label: 'Location',
                items: _getLocations(),
                onChanged: (wallLocation) {
                  if (_formModel.wallLocation != wallLocation) {
                    widget.setDirtyForm();
                    setState(() {
                      _formModel.wallLocation = wallLocation;
                    });
                  }
                },
                initialValue: widget.editRouteModel?.wallLocation,
              ),
              SizedBox(height: FreeBetaSizes.l),
              if (_formModel.wallLocation != null) ...[
                FreeBetaWallSectionInput(
                  label: 'Select section',
                  wallLocation: _formModel.wallLocation!,
                  value: _formModel.wallLocationIndex,
                  onChanged: (i) {
                    widget.setDirtyForm();
                    setState((() => _formModel.wallLocationIndex = i));
                  },
                ),
                SizedBox(height: FreeBetaSizes.l),
              ],
              FreeBetaDropdownList<RouteColor?>(
                label: 'Color',
                items: _getColors(),
                onChanged: (routeColor) {
                  if (routeColor != _formModel.routeColor) {
                    widget.setDirtyForm();
                    setState(() {
                      _formModel.routeColor = routeColor;
                    });
                  }
                },
                initialValue: widget.editRouteModel?.routeColor,
              ),
              SizedBox(height: FreeBetaSizes.l),
              FreeBetaDropdownList<ClimbType?>(
                label: 'Type',
                items: _getTypes(),
                onChanged: (climbType) {
                  if (_formModel.climbType != climbType) {
                    widget.setDirtyForm();
                    setState(() {
                      _formModel.climbType = climbType;
                    });
                  }
                },
                initialValue: widget.editRouteModel?.climbType,
              ),
              SizedBox(height: FreeBetaSizes.l),
              if (_formModel.climbType != null &&
                  _formModel.climbType == ClimbType.boulder) ...[
                FreeBetaDropdownList<BoulderRating?>(
                  label: 'Rating',
                  items: _getBoulderRatings(),
                  onChanged: (boulderRating) {
                    if (_formModel.boulderRating != boulderRating) {
                      widget.setDirtyForm();
                      setState(() {
                        _formModel.boulderRating = boulderRating;
                      });
                    }
                  },
                  initialValue: widget.editRouteModel?.boulderRating,
                ),
                SizedBox(height: FreeBetaSizes.l),
              ],
              if (_formModel.climbType != null &&
                  _formModel.climbType != ClimbType.boulder) ...[
                FreeBetaDropdownList<YosemiteRating?>(
                  label: 'Rating',
                  items: _getYosemiteRatings(),
                  onChanged: (yosemiteRating) {
                    if (_formModel.yosemiteRating != yosemiteRating) {
                      widget.setDirtyForm();
                      setState(() {
                        _formModel.yosemiteRating = yosemiteRating;
                      });
                    }
                  },
                  initialValue: widget.editRouteModel?.yosemiteRating,
                ),
                SizedBox(height: FreeBetaSizes.l),
              ],
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
              widget.editRouteModel == null
                  ? _CreateRouteButton(
                      onPressed: !_loadingImages && !_loadingBetaVideo
                          ? () async => _onCreateRoutePressed(context)
                          : null,
                    )
                  : _EditRouteButton(
                      onPressed: !_loadingImages && !_loadingBetaVideo
                          ? () async => _onEditRoutePressed(context)
                          : null,
                    ),
            ],
          ),
        ),
      ),
    );
  }

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

    widget.setDirtyForm();
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

    widget.setDirtyForm();
    setState(() {
      _formModel.removalDate = pickedDate;
      _removalDateController.value = TextEditingValue(
        text: DateFormat('MM/dd').format(pickedDate),
      );
    });
  }

  Future<void> _onImagePressed(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    var mediaApi = ref.read(mediaApiProvider);
    var imageSource = await chooseOption(context);
    if (imageSource == null) return;

    setState(() {
      _loadingImages = true;
    });

    var imageFile = await mediaApi.fetchImage(imageSource);

    setState(() {
      _loadingImages = false;
    });

    if (imageFile == null) return;

    widget.setDirtyForm();
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

  Future<void> _onBetaVideoPressed(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    var mediaApi = ref.read(mediaApiProvider);
    var imageSource = await chooseOption(context);
    if (imageSource == null) return;

    setState(() {
      _loadingBetaVideo = true;
      _betaVideoController.value = TextEditingValue(
        text: 'Loading..',
      );
    });

    var videoFile = await mediaApi.fetchVideo(imageSource);

    setState(() {
      _loadingBetaVideo = false;
    });

    if (videoFile == null) return;

    widget.setDirtyForm();
    setState(() {
      _formModel.betaVideo = videoFile;
      _betaVideoController.value = TextEditingValue(
        text: 'Edit beta video',
      );
    });
  }

  List<DropdownMenuItem<WallLocation?>> _getLocations() => WallLocation.values
      .map(
        (wallLocation) => DropdownMenuItem<WallLocation?>(
          value: wallLocation,
          child: Text(wallLocation.displayName),
        ),
      )
      .toList();

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

  List<DropdownMenuItem<BoulderRating?>> _getBoulderRatings() =>
      BoulderRating.values
          .map(
            (boulderRating) => DropdownMenuItem<BoulderRating?>(
              value: boulderRating,
              child: Text(boulderRating.displayName),
            ),
          )
          .toList();

  List<DropdownMenuItem<YosemiteRating?>> _getYosemiteRatings() =>
      YosemiteRating.values
          .map(
            (yosemiteRating) => DropdownMenuItem<YosemiteRating?>(
              value: yosemiteRating,
              child: Text(yosemiteRating.displayName),
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

  String get _betaVideoHintText {
    if (_loadingBetaVideo) {
      return 'Loading...';
    }
    if (_formModel.betaVideo != null) {
      return 'Edit beta video';
    }
    return 'Add beta video';
  }

  Future<ImageSource?> chooseOption(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) => _ImageSourceDialog(),
    );
  }
}

class _CreateRouteButton extends StatelessWidget {
  const _CreateRouteButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
  }
}

class _EditRouteButton extends StatelessWidget {
  const _EditRouteButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
  }
}

class _ImageSourceDialog extends StatelessWidget {
  const _ImageSourceDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Upload media'),
      actions: [
        ElevatedButton(
          child: Text('Camera'),
          onPressed: () {
            Navigator.of(context).pop(ImageSource.camera);
          },
        ),
        ElevatedButton(
          child: Text('Photos'),
          onPressed: () {
            Navigator.of(context).pop(ImageSource.gallery);
          },
        ),
      ],
    );
  }
}

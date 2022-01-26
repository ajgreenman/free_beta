import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/back_button.dart';
import 'package:free_beta/app/presentation/text_field.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/user_route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_images.dart';
import 'package:free_beta/routes/presentation/route_summary.dart';
import 'package:free_beta/user/user_route_model.dart';

class RouteDetailScreen extends ConsumerStatefulWidget {
  static Route<dynamic> route(RouteModel routeModel) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return RouteDetailScreen(routeModel: routeModel);
    });
  }

  final RouteModel routeModel;

  const RouteDetailScreen({Key? key, required this.routeModel})
      : super(key: key);

  @override
  _RouteDetailScreenState createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends ConsumerState<RouteDetailScreen> {
  late UserRouteFormModel _formModel;
  bool dirtyForm = false;

  @override
  void initState() {
    super.initState();
    _formModel = UserRouteFormModel(
      isAttempted: widget.routeModel.userRouteModel?.isAttempted ?? false,
      isCompleted: widget.routeModel.userRouteModel?.isCompleted ?? false,
      isFavorited: widget.routeModel.userRouteModel?.isFavorited ?? false,
      rating: widget.routeModel.userRouteModel?.rating,
      notes: widget.routeModel.userRouteModel?.notes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: FreeBetaBackButton(onPressed: _onBack),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: FreeBetaPadding.xxlAll,
          child: SingleChildScrollView(
            child: Column(
              children: [
                RouteSummary(widget.routeModel, isDetailed: true),
                _buildDivider(),
                _buildImages(),
                _buildDivider(),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCheckboxRow('Attempted', _buildAttemptedCheckbox()),
                      _buildCheckboxRow('Completed', _buildCompletedCheckbox()),
                      _buildCheckboxRow('Favorited', _buildFavoritedCheckbox()),
                      SizedBox(height: FreeBetaSizes.m),
                      _buildRating(),
                      ..._buildNotes(),
                      ElevatedButton(
                        onPressed: _onSave,
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImages() {
    return RouteImages(images: widget.routeModel.images);
  }

  Widget _buildCheckboxRow(String label, Checkbox checkbox) {
    return Padding(
      padding: FreeBetaPadding.sVertical,
      child: Row(
        children: [
          Text(
            label,
            style: FreeBetaTextStyle.body3,
          ),
          Spacer(),
          SizedBox.square(dimension: FreeBetaSizes.xl, child: checkbox),
        ],
      ),
    );
  }

  Checkbox _buildAttemptedCheckbox() => Checkbox(
        activeColor: FreeBetaColors.blueDark,
        value: _formModel.isAttempted,
        onChanged: (value) {
          if (value == null || value == _formModel.isAttempted) return;
          dirtyForm = true;

          setState(() {
            _formModel.isAttempted = value;
            if (!value) {
              _formModel.isCompleted = false;
              _formModel.isFavorited = false;
            }
          });
        },
      );

  Checkbox _buildCompletedCheckbox() => Checkbox(
        activeColor: FreeBetaColors.blueDark,
        value: _formModel.isCompleted,
        onChanged: (value) {
          if (value == null || value == _formModel.isCompleted) return;
          dirtyForm = true;

          setState(() {
            _formModel.isCompleted = value;
            if (value) {
              _formModel.isAttempted = true;
            }
          });
        },
      );

  Checkbox _buildFavoritedCheckbox() => Checkbox(
        activeColor: FreeBetaColors.blueDark,
        value: _formModel.isFavorited,
        onChanged: (value) {
          if (value == null || value == _formModel.isFavorited) return;
          dirtyForm = true;

          setState(() {
            _formModel.isFavorited = value;
            if (value) {
              _formModel.isAttempted = true;
            }
          });
        },
      );

  List<Widget> _buildNotes() {
    return [
      Text(
        'Notes',
        style: FreeBetaTextStyle.body3,
      ),
      SizedBox(height: FreeBetaSizes.m),
      FreeBetaTextField(
        initialValue: _formModel.notes,
        onChanged: (value) {
          if (value != _formModel.notes) {
            dirtyForm = true;
            setState(() {
              _formModel.notes = value;
            });
          }
        },
      ),
    ];
  }

  Widget _buildRating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating',
          style: FreeBetaTextStyle.body3,
        ),
        Spacer(),
        _buildRatingRadio(RouteRating.one),
        SizedBox(width: FreeBetaSizes.s),
        _buildRatingRadio(RouteRating.two),
        SizedBox(width: FreeBetaSizes.s),
        _buildRatingRadio(RouteRating.three),
      ],
    );
  }

  void _onBack() async {
    if (!dirtyForm) {
      Navigator.of(context).pop();
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => _AreYouSureDialog(),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: FreeBetaPadding.mlAll,
      child: Divider(
        height: 2,
        thickness: 2,
      ),
    );
  }

  Widget _buildRatingRadio(RouteRating value) => SizedBox.square(
        dimension: FreeBetaSizes.xxl,
        child: Radio<RouteRating>(
          toggleable: true,
          value: value,
          groupValue: _formModel.rating,
          onChanged: (value) {
            if (value != _formModel.rating) {
              dirtyForm = true;
              setState(() {
                _formModel.rating = value;
              });
            }
          },
        ),
      );

  Future<void> _onSave() async {
    await ref.read(routeApiProvider).saveRoute(
          UserRouteModel(
            routeId: widget.routeModel.id,
            isAttempted: _formModel.isAttempted,
            isCompleted: _formModel.isCompleted,
            isFavorited: _formModel.isFavorited,
            rating: _formModel.rating,
            notes: _formModel.notes,
          ),
        );
    ref.refresh(fetchRoutesProvider);

    dirtyForm = false;

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Saved!'),
            Spacer(),
            Icon(Icons.check),
          ],
        ),
      ),
    );
  }
}

class _AreYouSureDialog extends StatelessWidget {
  const _AreYouSureDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content:
          Text("You have unsaved changes, are you sure you want to leave?"),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Leave'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

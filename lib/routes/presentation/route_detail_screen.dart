import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/text_field.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/edit_route_screen.dart';
import 'package:free_beta/routes/infrastructure/models/user_route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/infrastructure/route_local_data_provider.dart';
import 'package:free_beta/routes/presentation/route_images.dart';
import 'package:free_beta/routes/presentation/route_summary.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';

class RouteDetailScreen extends ConsumerStatefulWidget {
  static Route<dynamic> route(RouteModel routeModel, {isHelp = false}) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return RouteDetailScreen(routeModel: routeModel, isHelp: isHelp);
    });
  }

  final RouteModel routeModel;
  final bool isHelp;

  const RouteDetailScreen({
    Key? key,
    required this.routeModel,
    this.isHelp = false,
  }) : super(key: key);

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
      notes: widget.routeModel.userRouteModel?.notes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.routeModel.name),
        leading: FreeBetaBackButton(onPressed: _onBack),
        actions: [_buildEditButton(context)],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: FreeBetaPadding.lAll,
            child: Column(
              children: [
                if (widget.isHelp) _buildHelp(),
                RouteSummary(widget.routeModel, isDetailed: true),
                _buildDivider(),
                RouteImages(images: widget.routeModel.images),
                _buildDivider(),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCheckboxRow('Attempted', _buildAttemptedCheckbox()),
                      _buildCheckboxRow('Completed', _buildCompletedCheckbox()),
                      _buildCheckboxRow('Favorited', _buildFavoritedCheckbox()),
                      SizedBox(height: FreeBetaSizes.m),
                      ..._buildNotes(),
                      ElevatedButton(
                        onPressed: widget.isHelp ? null : _onSave,
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

  Widget _buildEditButton(BuildContext context) {
    var button = ref.watch(authenticationProvider).whenOrNull(
      data: (user) {
        if (user != null) {
          return IconButton(
            onPressed: () => Navigator.of(context).push(
              EditRouteScreen.route(widget.routeModel),
            ),
            icon: Icon(
              Icons.edit,
              color: FreeBetaColors.white,
            ),
          );
        }
      },
    );

    return button ?? SizedBox.shrink();
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
          SizedBox.square(dimension: FreeBetaSizes.xxl, child: checkbox),
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
        hintText: 'Enter notes here:\n\nex. flag your left foot',
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

  Widget _buildDivider() => Padding(
        padding: const EdgeInsets.symmetric(vertical: FreeBetaSizes.ml),
        child: Divider(
          height: 2,
          thickness: 2,
        ),
      );

  Widget _buildHelp() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.warning_amber,
              color: FreeBetaColors.warning,
            ),
            SizedBox(width: FreeBetaSizes.l),
            Flexible(
              child: Text(
                'This is a sample route, your changes cannot be saved.',
                style: FreeBetaTextStyle.h4.copyWith(
                  color: FreeBetaColors.grayLight,
                ),
              ),
            ),
          ],
        ),
        _buildDivider(),
      ],
    );
  }

  void _onBack() async {
    if (!dirtyForm || widget.isHelp) {
      Navigator.of(context).pop();
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => _AreYouSureDialog(),
    );
  }

  Future<void> _onSave() async {
    await ref.read(routeApiProvider).saveRoute(
          UserRouteModel(
            routeId: widget.routeModel.id,
            isAttempted: _formModel.isAttempted,
            isCompleted: _formModel.isCompleted,
            isFavorited: _formModel.isFavorited,
            notes: _formModel.notes,
          ),
        );
    ref.refresh(fetchRoutesProvider);
    ref.refresh(fetchUserRoutesProvider);

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

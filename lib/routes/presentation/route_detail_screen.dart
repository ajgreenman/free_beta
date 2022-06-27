import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/form/number_input.dart';
import 'package:free_beta/app/presentation/widgets/text_field.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/edit_route_screen.dart';
import 'package:free_beta/routes/infrastructure/models/user_route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_images.dart';
import 'package:free_beta/routes/presentation/route_summary.dart';
import 'package:free_beta/routes/presentation/route_video_screen.dart';
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
      isCompleted: widget.routeModel.userRouteModel?.isCompleted ?? false,
      isFavorited: widget.routeModel.userRouteModel?.isFavorited ?? false,
      attempts: widget.routeModel.userRouteModel?.attempts ?? 0,
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
                _DetailScreenDivider(),
                RouteImages(images: widget.routeModel.images),
                _BetaVideoButton(betaVideo: widget.routeModel.betaVideo),
                _DetailScreenDivider(),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAttemptsRow(),
                      _buildCheckboxRow('Completed', _buildCompletedCheckbox()),
                      _buildCheckboxRow('Favorited', _buildFavoritedCheckbox()),
                      SizedBox(height: FreeBetaSizes.ml),
                      ..._buildNotes(),
                      ElevatedButton(
                        onPressed: widget.isHelp ? null : _onSave,
                        child: Text(
                          'Save',
                          style: FreeBetaTextStyle.body2.copyWith(
                            color: FreeBetaColors.white,
                          ),
                        ),
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
    var user = ref.watch(authenticationProvider).whenOrNull(
          data: (user) => user,
        );

    if (user != null && !user.isAnonymous) {
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

    return SizedBox.shrink();
  }

  Widget _buildCheckboxRow(String label, Checkbox checkbox) {
    return Padding(
      padding: FreeBetaPadding.sVertical,
      child: Row(
        children: [
          Text(
            label,
            style: FreeBetaTextStyle.body2,
          ),
          Spacer(),
          SizedBox.square(dimension: FreeBetaSizes.xxl, child: checkbox),
          SizedBox(width: FreeBetaSizes.m),
        ],
      ),
    );
  }

  Widget _buildAttemptsRow() {
    return Padding(
      padding: FreeBetaPadding.sVertical,
      child: Row(
        children: [
          Text(
            'Attempts',
            style: FreeBetaTextStyle.body2,
          ),
          Spacer(),
          FreeBetaNumberInput(
            value: _formModel.attempts,
            onChanged: (value) {
              if (value == _formModel.attempts) return;
              dirtyForm = true;

              setState(() {
                _formModel.attempts = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Checkbox _buildCompletedCheckbox() => Checkbox(
        activeColor: FreeBetaColors.blueDark,
        value: _formModel.isCompleted,
        onChanged: (value) {
          if (value == null || value == _formModel.isCompleted) return;
          dirtyForm = true;

          setState(() {
            _formModel.isCompleted = value;
            if (value && _formModel.attempts == 0) {
              _formModel.attempts++;
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
            if (value && _formModel.attempts == 0) {
              _formModel.attempts++;
            }
          });
        },
      );

  List<Widget> _buildNotes() {
    return [
      Text(
        'Notes',
        style: FreeBetaTextStyle.body2,
      ),
      SizedBox(height: FreeBetaSizes.ml),
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
        _DetailScreenDivider(),
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
      builder: (_) => _AreYouSureDialog(onSave: _onSave),
    );
  }

  Future<void> _onSave() async {
    var user = ref.read(authenticationProvider).whenOrNull(
          data: (user) => user,
        );

    await ref.read(routeApiProvider).saveRoute(
          UserRouteModel(
            userId: user!.uid,
            routeId: widget.routeModel.id,
            isCompleted: _formModel.isCompleted,
            isFavorited: _formModel.isFavorited,
            attempts: _formModel.attempts,
            notes: _formModel.notes,
          ),
        );
    ref.refresh(fetchRoutesProvider);
    ref.refresh(fetchUserStatsProvider);

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

class _DetailScreenDivider extends StatelessWidget {
  const _DetailScreenDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FreeBetaSizes.ml),
      child: Divider(
        height: 2,
        thickness: 2,
      ),
    );
  }
}

class _BetaVideoButton extends StatelessWidget {
  const _BetaVideoButton({
    Key? key,
    required this.betaVideo,
  }) : super(key: key);

  final String? betaVideo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: FreeBetaSizes.ml),
        ElevatedButton(
          onPressed: betaVideo != null
              ? () =>
                  Navigator.of(context).push(RouteVideoScreen.route(betaVideo!))
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                betaVideo != null
                    ? 'View beta video'
                    : 'Beta video not available',
              ),
              if (betaVideo != null)
                Padding(
                  padding: const EdgeInsets.only(left: FreeBetaSizes.ml),
                  child: Icon(
                    Icons.tap_and_play,
                    size: FreeBetaSizes.l,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AreYouSureDialog extends StatelessWidget {
  const _AreYouSureDialog({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Text("You have unsaved changes, are you sure you want to exit?"),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            textAlign: TextAlign.end,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(width: FreeBetaSizes.s),
        TextButton(
          child: Text(
            'Exit',
            textAlign: TextAlign.end,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
        SizedBox(width: FreeBetaSizes.s),
        TextButton(
          child: Text(
            'Save & Exit',
            textAlign: TextAlign.end,
          ),
          onPressed: () {
            onSave();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

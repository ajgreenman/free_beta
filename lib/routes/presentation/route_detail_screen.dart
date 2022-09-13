import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/form/number_input.dart';
import 'package:free_beta/app/presentation/widgets/text_field.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/edit_route_screen.dart';
import 'package:free_beta/routes/infrastructure/models/user_route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/routes/presentation/route_images.dart';
import 'package:free_beta/routes/presentation/route_summary.dart';
import 'package:free_beta/routes/presentation/route_video_screen.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';
import 'package:video_player/video_player.dart';

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
        actions: [_EditButton(routeModel: widget.routeModel)],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: FreeBetaPadding.lAll,
            child: Column(
              children: [
                if (widget.isHelp) _HelpWarning(),
                RouteSummary(widget.routeModel, isDetailed: true),
                _DetailScreenDivider(),
                RouteImages(images: widget.routeModel.images),
                _BetaVideoButton(betaVideo: widget.routeModel.betaVideo),
                _DetailScreenDivider(),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AttemptsRow(
                        attempts: _formModel.attempts,
                        onChanged: _onAttemptsChanged,
                      ),
                      _CheckboxRow(
                        label: 'Completed',
                        checkbox: _Checkbox(
                          key: Key('Checkbox-completed'),
                          value: _formModel.isCompleted,
                          onChanged: _onCompletedChanged,
                        ),
                      ),
                      _CheckboxRow(
                        label: 'Favorited',
                        checkbox: _Checkbox(
                          key: Key('Checkbox-favorited'),
                          value: _formModel.isFavorited,
                          onChanged: _onFavoritedChanged,
                        ),
                      ),
                      SizedBox(height: FreeBetaSizes.ml),
                      _Notes(
                        initialValue: _formModel.notes,
                        onChanged: _onNotesChanged,
                      ),
                      ElevatedButton(
                        key: Key('ElevatedButton-save'),
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

  _onNotesChanged(value) {
    if (value != _formModel.notes) {
      dirtyForm = true;
      setState(() {
        _formModel.notes = value;
      });
    }
  }

  void _onFavoritedChanged(value) {
    if (value == null || value == _formModel.isFavorited) return;
    dirtyForm = true;

    setState(() {
      _formModel.isFavorited = value;
      if (value && _formModel.attempts == 0) {
        _formModel.attempts++;
      }
    });
  }

  void _onCompletedChanged(value) {
    if (value == null || value == _formModel.isCompleted) return;
    dirtyForm = true;

    setState(() {
      _formModel.isCompleted = value;
      if (value && _formModel.attempts == 0) {
        _formModel.attempts++;
      }
    });
  }

  void _onAttemptsChanged(value) {
    if (value == _formModel.attempts) return;
    dirtyForm = true;

    setState(() {
      _formModel.attempts = value;
      if (_formModel.attempts == 0) {
        _formModel.isCompleted = false;
        _formModel.isFavorited = false;
      }
    });
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

class _Notes extends StatelessWidget {
  const _Notes({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  final String? initialValue;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Notes',
          style: FreeBetaTextStyle.body2,
        ),
        SizedBox(height: FreeBetaSizes.ml),
        FreeBetaTextField(
          initialValue: initialValue,
          hintText: 'Enter notes here:\n\nex. flag your left foot',
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: FreeBetaColors.blueDark,
      value: value,
      onChanged: onChanged,
    );
  }
}

class _CheckboxRow extends StatelessWidget {
  const _CheckboxRow({
    Key? key,
    required this.label,
    required this.checkbox,
  }) : super(key: key);

  final String label;
  final _Checkbox checkbox;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FreeBetaPadding.sVertical,
      child: Row(
        children: [
          Text(
            label,
            style: FreeBetaTextStyle.body2,
          ),
          Spacer(),
          SizedBox.square(
            dimension: FreeBetaSizes.xxl,
            child: checkbox,
          ),
          SizedBox(width: FreeBetaSizes.m),
        ],
      ),
    );
  }
}

class _AttemptsRow extends StatelessWidget {
  const _AttemptsRow({
    Key? key,
    required this.attempts,
    required this.onChanged,
  }) : super(key: key);

  final int attempts;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
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
            value: attempts,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _HelpWarning extends StatelessWidget {
  const _HelpWarning({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                style: FreeBetaTextStyle.h4,
              ),
            ),
          ],
        ),
        _DetailScreenDivider(),
      ],
    );
  }
}

class _EditButton extends ConsumerWidget {
  const _EditButton({
    Key? key,
    required this.routeModel,
  }) : super(key: key);

  final RouteModel routeModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(authenticationProvider).whenOrNull(
          data: (user) => user,
        );

    if (user == null || user.isAnonymous) {
      return SizedBox.shrink();
    }

    return IconButton(
      onPressed: () => Navigator.of(context).push(
        EditRouteScreen.route(routeModel),
      ),
      icon: Icon(
        Icons.edit,
        color: FreeBetaColors.white,
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
              ? () => Navigator.of(context).push(RouteVideoScreen.route(
                    VideoPlayerController.network(betaVideo!),
                  ))
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

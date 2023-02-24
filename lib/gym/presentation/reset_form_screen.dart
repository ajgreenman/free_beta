import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/form/button_input.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/infrastructure/gym_providers.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';
import 'package:free_beta/gym/infrastructure/models/wall_section_model.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';
import 'package:intl/intl.dart';

class ResetFormScreen extends ConsumerStatefulWidget {
  static Route<dynamic> add() {
    return MaterialPageRoute(
      builder: (context) => ResetFormScreen(editResetModel: null),
    );
  }

  static Route<dynamic> edit(ResetModel editResetModel) {
    return MaterialPageRoute(
      builder: (context) => ResetFormScreen(editResetModel: editResetModel),
    );
  }

  ResetFormScreen({required this.editResetModel});

  final ResetModel? editResetModel;

  @override
  ConsumerState<ResetFormScreen> createState() => _AddResetScreenState();
}

class _AddResetScreenState extends ConsumerState<ResetFormScreen> {
  late ResetFormModel _resetFormModel;
  late TextEditingController _resetDateController;

  @override
  void initState() {
    super.initState();

    if (widget.editResetModel != null) {
      _setupEdit();
    } else {
      _setupAdd();
    }
  }

  void _setupAdd() {
    _resetFormModel = ResetFormModel();
    _resetDateController = TextEditingController();
  }

  void _setupEdit() {
    _resetFormModel = ResetFormModel.fromRouteModel(
      widget.editResetModel!,
    );

    _resetDateController = TextEditingController(
      text: DateFormat('MM/dd').format(widget.editResetModel!.date),
    );
  }

  List<int> _sections(WallLocation location) {
    var sections = <int>[];
    _resetFormModel.sections.forEach((section) {
      if (section.wallLocation == location) {
        sections.add(section.wallSection);
      }
    });
    return sections;
  }

  bool get isAdd => widget.editResetModel == null;
  bool get isFormEmpty =>
      _resetFormModel.date == null && _resetFormModel.sections.isEmpty;
  bool get isFormIncomplete =>
      _resetFormModel.date == null || _resetFormModel.sections.isEmpty;
  bool get isFormUnedited =>
      !isAdd &&
      ResetFormModel.fromRouteModel(widget.editResetModel!) == _resetFormModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('reset-form'),
      appBar: AppBar(
        title: Text(
          isAdd ? 'Add Reset' : 'Edit Reset',
        ),
        leading: FreeBetaBackButton(onPressed: _onBack),
        actions: [
          _DeleteButton(
            key: Key('ResetFormScreen-delete'),
            resetModel: widget.editResetModel,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FreeBetaButtonInput(
                key: Key('AddResetScreen-resetDate'),
                label: 'Reset Date',
                hintText: 'Enter reset date',
                onTap: _onResetDatePressed,
                controller: _resetDateController,
              ),
              ...WallLocation.values
                  .map(
                    (location) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.displayName,
                          style: FreeBetaTextStyle.h4,
                        ),
                        SizedBox(height: FreeBetaSizes.m),
                        WallSectionMap(
                          key: Key('AddResetScreen-section-${location.name}'),
                          wallLocation: location,
                          isForm: true,
                          highlightedSections: _sections(location),
                          onPressed: (i) => _onSectionPressed(location, i),
                        ),
                        SizedBox(height: FreeBetaSizes.m),
                      ],
                    ),
                  )
                  .toList(),
              SizedBox(height: FreeBetaSizes.m),
              ElevatedButton(
                onPressed: isFormIncomplete ? null : _onPressed,
                child: Padding(
                  padding: FreeBetaPadding.xlHorizontal,
                  child: Text(
                    isAdd ? 'Add' : 'Update',
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBack() async {
    if ((isAdd && isFormEmpty) || isFormUnedited) {
      Navigator.of(context).pop();
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => _SaveAreYouSureDialog(),
    );
  }

  Future<void> _onResetDatePressed() async {
    FocusScope.of(context).requestFocus(FocusNode());

    var pickedDate = await showDatePicker(
      context: context,
      initialDate: _resetFormModel.date ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate == null) return;

    setState(() {
      _resetFormModel.date = pickedDate;
      _resetDateController.value = TextEditingValue(
        text: DateFormat('MM/dd').format(pickedDate),
      );
    });
  }

  void _onSectionPressed(WallLocation location, int i) {
    var wallSection = WallSectionModel(
      wallLocation: location,
      wallSection: i,
    );
    if (_resetFormModel.sections.contains(wallSection)) {
      setState(() {
        _resetFormModel.sections.remove(wallSection);
      });
    } else {
      setState(() {
        _resetFormModel.sections = [..._resetFormModel.sections, wallSection];
      });
    }
  }

  void _onPressed() async {
    if (widget.editResetModel == null) {
      _onAddPressed();
    } else {
      _onEditPressed();
    }
  }

  void _onAddPressed() async {
    await ref.read(gymApiProvider).addReset(_resetFormModel);

    ref.invalidate(resetScheduleProvider);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Reset added!'),
            Spacer(),
            Icon(Icons.check),
          ],
        ),
      ),
    );
    Navigator.of(context).pop();
  }

  void _onEditPressed() async {
    await ref.read(gymApiProvider).updateReset(
          widget.editResetModel!,
          _resetFormModel,
        );

    ref.invalidate(resetScheduleProvider);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Reset updated!'),
            Spacer(),
            Icon(Icons.check),
          ],
        ),
      ),
    );
    Navigator.of(context).pop();
  }
}

class _DeleteButton extends ConsumerWidget {
  const _DeleteButton({
    super.key,
    required this.resetModel,
  });

  final ResetModel? resetModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (resetModel == null) return SizedBox.shrink();

    return IconButton(
      onPressed: () => _onDeletePressed(context, ref),
      icon: Icon(
        Icons.delete,
        color: FreeBetaColors.white,
      ),
    );
  }

  Future<void> _onDeletePressed(BuildContext context, WidgetRef ref) async {
    var willDelete = await showDialog(
      context: context,
      builder: (_) => _DeleteAreYouSureDialog(),
    );
    if (!(willDelete ?? false)) return;

    await ref.read(gymApiProvider).deleteReset(
          resetModel!,
        );
    ref.invalidate(resetScheduleProvider);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Reset deleted!'),
            Spacer(),
            Icon(Icons.delete),
          ],
        ),
      ),
    );
    Navigator.of(context).pop();
  }
}

class _SaveAreYouSureDialog extends StatelessWidget {
  const _SaveAreYouSureDialog({
    Key? key,
  }) : super(key: key);

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
      ],
    );
  }
}

class _DeleteAreYouSureDialog extends StatelessWidget {
  const _DeleteAreYouSureDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Text("Are you sure you want to delete this reset?"),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text('Delete'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}

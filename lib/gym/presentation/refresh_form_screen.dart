import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/form/button_input.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/infrastructure/gym_providers.dart';
import 'package:free_beta/gym/infrastructure/models/refresh_model.dart';
import 'package:free_beta/gym/infrastructure/models/wall_section_model.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';
import 'package:intl/intl.dart';

class RefreshFormScreen extends ConsumerStatefulWidget {
  static Route<dynamic> add() {
    return MaterialPageRoute(
      builder: (context) => RefreshFormScreen(editRefreshModel: null),
    );
  }

  static Route<dynamic> edit(RefreshModel editRefreshModel) {
    return MaterialPageRoute(
      builder: (context) =>
          RefreshFormScreen(editRefreshModel: editRefreshModel),
    );
  }

  RefreshFormScreen({required this.editRefreshModel});

  final RefreshModel? editRefreshModel;

  @override
  ConsumerState<RefreshFormScreen> createState() => _AddRefreshScreenState();
}

class _AddRefreshScreenState extends ConsumerState<RefreshFormScreen> {
  late RefreshFormModel _refreshFormModel;
  late TextEditingController _refreshDateController;

  @override
  void initState() {
    super.initState();

    if (widget.editRefreshModel != null) {
      _setupEdit();
    } else {
      _setupAdd();
    }
  }

  void _setupAdd() {
    _refreshFormModel = RefreshFormModel();
    _refreshDateController = TextEditingController();
  }

  void _setupEdit() {
    _refreshFormModel = RefreshFormModel.fromRouteModel(
      widget.editRefreshModel!,
    );

    _refreshDateController = TextEditingController(
      text: DateFormat('MM/dd').format(widget.editRefreshModel!.date),
    );
  }

  List<int> _sections(WallLocation location) {
    var sections = <int>[];
    _refreshFormModel.sections.forEach((section) {
      if (section.wallLocation == location) {
        sections.add(section.wallSection);
      }
    });
    return sections;
  }

  bool get isAdd => widget.editRefreshModel == null;
  bool get isFormEmpty =>
      _refreshFormModel.date == null && _refreshFormModel.sections.isEmpty;
  bool get isFormIncomplete =>
      _refreshFormModel.date == null || _refreshFormModel.sections.isEmpty;
  bool get isFormUnedited =>
      !isAdd &&
      RefreshFormModel.fromRouteModel(widget.editRefreshModel!) ==
          _refreshFormModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('refresh-form'),
      appBar: AppBar(
        title: Text(
          isAdd ? 'Add Refresh' : 'Edit Refresh',
        ),
        leading: FreeBetaBackButton(onPressed: _onBack),
        actions: [
          _DeleteButton(
            key: Key('RefreshFormScreen-delete'),
            refreshModel: widget.editRefreshModel,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FreeBetaButtonInput(
                key: Key('AddRefreshScreen-refreshDate'),
                label: 'Refresh Date',
                hintText: 'Enter refresh date',
                onTap: _onRefreshDatePressed,
                controller: _refreshDateController,
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
                          key: Key('AddRefreshScreen-section-${location.name}'),
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

  Future<void> _onRefreshDatePressed() async {
    FocusScope.of(context).requestFocus(FocusNode());

    var pickedDate = await showDatePicker(
      context: context,
      initialDate: _refreshFormModel.date ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate == null) return;

    setState(() {
      _refreshFormModel.date = pickedDate;
      _refreshDateController.value = TextEditingValue(
        text: DateFormat('MM/dd').format(pickedDate),
      );
    });
  }

  void _onSectionPressed(WallLocation location, int i) {
    var wallSection = WallSectionModel(
      wallLocation: location,
      wallSection: i,
    );
    if (_refreshFormModel.sections.contains(wallSection)) {
      setState(() {
        _refreshFormModel.sections.remove(wallSection);
      });
    } else {
      setState(() {
        _refreshFormModel.sections = [
          ..._refreshFormModel.sections,
          wallSection
        ];
      });
    }
  }

  void _onPressed() async {
    if (widget.editRefreshModel == null) {
      _onAddPressed();
    } else {
      _onEditPressed();
    }
  }

  void _onAddPressed() async {
    await ref.read(gymApiProvider).addRefresh(_refreshFormModel);

    ref.refresh(refreshScheduleProvider);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Refresh added!'),
            Spacer(),
            Icon(Icons.check),
          ],
        ),
      ),
    );
    Navigator.of(context).pop();
  }

  void _onEditPressed() async {
    await ref.read(gymApiProvider).updateRefresh(
          widget.editRefreshModel!,
          _refreshFormModel,
        );

    ref.refresh(refreshScheduleProvider);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Refresh updated!'),
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
    required this.refreshModel,
  });

  final RefreshModel? refreshModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (refreshModel == null) return SizedBox.shrink();

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

    await ref.read(gymApiProvider).deleteRefresh(
          refreshModel!,
        );
    ref.refresh(refreshScheduleProvider);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Refresh deleted!'),
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
      content: Text("Are you sure you want to delete this refresh?"),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/class_type.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/app/extensions/string_extensions.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/form/button_input.dart';
import 'package:free_beta/app/presentation/widgets/form/dropdown_list.dart';
import 'package:free_beta/app/presentation/widgets/form/submit_button.dart';
import 'package:free_beta/app/presentation/widgets/form/text_input.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/class/infrastructure/class_providers.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/infrastructure/models/class_model.p.dart';
import 'package:intl/intl.dart';

class ClassFormScreen extends ConsumerStatefulWidget {
  static Route<dynamic> add(Day day) {
    return MaterialPageRoute(
      builder: (context) => ClassFormScreen(
        editClassModel: null,
        initialDay: day,
      ),
    );
  }

  static Route<dynamic> edit(ClassModel classModel) {
    return MaterialPageRoute(
      builder: (context) => ClassFormScreen(
        editClassModel: classModel,
        initialDay: classModel.day,
      ),
    );
  }

  ClassFormScreen({required this.editClassModel, required this.initialDay});

  final ClassModel? editClassModel;
  final Day initialDay;

  @override
  ConsumerState<ClassFormScreen> createState() => _ClassFormScreen();
}

class _ClassFormScreen extends ConsumerState<ClassFormScreen> {
  late ClassFormModel _classFormModel;

  late TextEditingController _nameController;
  late TextEditingController _instructorController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();

    if (widget.editClassModel != null) {
      _setupEdit();
    } else {
      _setupAdd();
    }
  }

  void _setupAdd() {
    _classFormModel = ClassFormModel(day: widget.initialDay);

    _nameController = TextEditingController();
    _instructorController = TextEditingController();
    _timeController = TextEditingController();
  }

  void _setupEdit() {
    _classFormModel = ClassFormModel.fromClassModel(
      widget.editClassModel!,
    );

    _nameController = TextEditingController(
      text: _classFormModel.name,
    );

    _instructorController = TextEditingController(
      text: _classFormModel.instructor,
    );

    _timeController = TextEditingController(
      text: DateFormat('h:mm a').formatWithNull(
        DateTime.now().copyWith(
          hour: _classFormModel.hour,
          minute: _classFormModel.minute,
        ),
      ),
    );
  }

  bool get isAdd => widget.editClassModel == null;
  bool get isFormEmpty =>
      _classFormModel.name.isNullOrEmpty &&
      _classFormModel.instructor.isNullOrEmpty &&
      _classFormModel.classType == null &&
      _classFormModel.hour == null &&
      _classFormModel.minute == null;
  bool get isFormComplete =>
      _classFormModel.name != null &&
      _classFormModel.name!.isNotEmpty &&
      _classFormModel.instructor != null &&
      _classFormModel.instructor!.isNotEmpty &&
      _classFormModel.classType != null &&
      _classFormModel.hour != null &&
      _classFormModel.minute != null;
  bool get isFormUnedited =>
      !isAdd &&
      ClassFormModel.fromClassModel(widget.editClassModel!) == _classFormModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('class-form'),
      appBar: AppBar(
        title: Text(
          isAdd ? 'Add Class' : 'Edit Class',
        ),
        leading: FreeBetaBackButton(onPressed: _onBack),
        actions: [
          _DeleteButton(
            key: Key('ClassFormScreen-delete'),
            classModel: widget.editClassModel,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FreeBetaTextInput(
                label: 'Class name',
                onChanged: _onNameChanged,
                controller: _nameController,
              ),
              FreeBetaTextInput(
                label: 'Instructor',
                onChanged: _onInstructorChanged,
                controller: _instructorController,
              ),
              FreeBetaDropdownList<Day>(
                label: 'Day',
                initialValue: _classFormModel.day ?? Day.friday,
                onChanged: _onDayChanged,
                items: Day.values
                    .map(
                      (day) => DropdownMenuItem<Day>(
                        value: day,
                        child: Text(day.name.withFirstLetterCapitalized),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: FreeBetaSizes.l),
              FreeBetaDropdownList<ClassType>(
                label: 'Class type',
                initialValue: _classFormModel.classType,
                onChanged: _onClassTypeChanged,
                items: ClassType.values
                    .map(
                      (classType) => DropdownMenuItem<ClassType>(
                        value: classType,
                        child: Text(classType.name.withFirstLetterCapitalized),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: FreeBetaSizes.l),
              FreeBetaButtonInput(
                label: 'Time',
                hintText: 'Enter start time',
                onTap: _onTimePressed,
                controller: _timeController,
              ),
              SizedBox(height: FreeBetaSizes.m),
              FreeBetaSubmitButton(
                onSubmit: _onSubmit,
                isAdd: isAdd,
                isFormComplete: isFormComplete,
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

  void _onClassTypeChanged(ClassType? classType) {
    setState(() {
      _classFormModel.classType = classType;
    });
  }

  void _onDayChanged(Day? day) {
    setState(() {
      _classFormModel.day = day;
    });
  }

  void _onInstructorChanged(String? instructor) {
    setState(() {
      _classFormModel.instructor = instructor;
    });
  }

  void _onNameChanged(String? name) {
    setState(() {
      _classFormModel.name = name;
    });
  }

  Future<void> _onTimePressed() async {
    FocusScope.of(context).requestFocus(FocusNode());

    var pickedTime = await showTimePicker(
      context: context,
      initialTime: _classFormModel.timeOfDay ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
    );
    if (pickedTime == null) return;

    setState(() {
      _classFormModel.hour = pickedTime.hour;
      _classFormModel.minute = pickedTime.minute;
      _timeController.value = TextEditingValue(
        text: DateFormat('h:mm a').formatWithNull(
          DateTime.now().copyWith(
            hour: _classFormModel.hour,
            minute: _classFormModel.minute,
          ),
        ),
      );
    });
  }

  void _onSubmit() async {
    if (isAdd) {
      _onAddPressed();
    } else {
      _onEditPressed();
    }
  }

  void _onAddPressed() async {
    await ref.read(classApiProvider).addClass(_classFormModel);

    ref.invalidate(fetchClassesProvider);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Class added!'),
            Spacer(),
            Icon(Icons.check),
          ],
        ),
      ),
    );
    Navigator.of(context).pop();
  }

  void _onEditPressed() async {
    await ref.read(classApiProvider).updateClass(
          widget.editClassModel!,
          _classFormModel,
        );

    ref.invalidate(fetchClassesProvider);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Class updated!'),
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
    required this.classModel,
  });

  final ClassModel? classModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (classModel == null) return SizedBox.shrink();

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

    await ref.read(classApiProvider).deleteClass(
          classModel!,
        );
    ref.invalidate(fetchClassesProvider);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Class deleted!'),
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
      content: Text("Are you sure you want to delete this class?"),
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

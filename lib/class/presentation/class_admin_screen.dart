import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/app/extensions/string_extensions.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/divider.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/presentation/widgets/form/dropdown_list.dart';
import 'package:free_beta/app/presentation/widgets/help_tooltip.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/class/infrastructure/class_providers.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/infrastructure/models/class_schedule_model.dart';
import 'package:free_beta/class/infrastructure/models/class_schedule_model.p.dart';
import 'package:free_beta/class/presentation/class_form_screen.dart';
import 'package:free_beta/class/presentation/class_image.dart';
import 'package:free_beta/class/presentation/widgets/class_row.dart';
import 'package:image_picker/image_picker.dart';

class ClassAdminScreen extends ConsumerWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => ClassAdminScreen());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: Key('edit-classes'),
      appBar: AppBar(
        title: Text('Edit Classes'),
        leading: FreeBetaBackButton(),
      ),
      body: ref.watch(getClassScheduleProvider).when(
            skipLoadingOnReload: true,
            data: (schedule) => _ClassAdmin(
              schedule: schedule,
            ),
            error: (error, stackTrace) => _Error(
              error: error,
              stackTrace: stackTrace,
            ),
            loading: () => _Loading(),
          ),
    );
  }
}

class _ClassAdmin extends ConsumerStatefulWidget {
  const _ClassAdmin({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  final List<ClassScheduleModel> schedule;

  @override
  ConsumerState<_ClassAdmin> createState() => _ClassesAdminState();
}

class _ClassesAdminState extends ConsumerState<_ClassAdmin> {
  late Day _currentDay;

  var _loadingImage = false;

  @override
  void initState() {
    super.initState();

    _currentDay = currentDay();
  }

  ClassScheduleModel get _currentSchedule => widget.schedule.firstWhere(
      (classScheduleModel) => classScheduleModel.day == _currentDay);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: FreeBetaPadding.mAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FreeBetaDropdownList<Day>(
                    label: 'Day',
                    initialValue: _currentDay,
                    onChanged: _updateDay,
                    items: Day.values
                        .map(
                          (day) => DropdownMenuItem<Day>(
                            value: day,
                            child: Text(day.name.withFirstLetterCapitalized),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: FreeBetaSizes.m),
                ],
              ),
            ),
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit classes',
                    style: FreeBetaTextStyle.h3,
                  ),
                  SizedBox(height: FreeBetaSizes.m),
                  FreeBetaDivider(),
                  SizedBox(height: FreeBetaSizes.s),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      ClassFormScreen.add(_currentDay),
                    ),
                    child: SizedBox(
                      width: 150.0,
                      child: Center(
                          child: Text(
                        'Add new class',
                        style: FreeBetaTextStyle.h4.copyWith(
                          color: FreeBetaColors.white,
                        ),
                      )),
                    ),
                  ),
                  SizedBox(height: FreeBetaSizes.s),
                  FreeBetaDivider(),
                  if (_currentSchedule.activeClasses.isEmpty) _NoClasses(),
                  if (_currentSchedule.activeClasses.isNotEmpty)
                    ..._currentSchedule.activeClasses
                        .map((classModel) =>
                            _EditClassRow(classModel: classModel))
                        .toList(),
                ],
              ),
            ),
            InfoCard(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Edit image',
                        style: FreeBetaTextStyle.h3,
                      ),
                      SizedBox(width: FreeBetaSizes.l),
                      HelpTooltip(
                        message:
                            'Adding an image will override the individual classes and just display the image. You will need to delete the image to go back to using individual classes.',
                      ),
                    ],
                  ),
                  SizedBox(height: FreeBetaSizes.m),
                  FreeBetaDivider(),
                  SizedBox(height: FreeBetaSizes.s),
                  if (_loadingImage)
                    SizedBox(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (!_loadingImage)
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _onAddImage,
                          child: SizedBox(
                            width: 150.0,
                            child: Center(
                              child: Text(
                                _currentSchedule.image != null
                                    ? 'Update image'
                                    : 'Add image',
                                style: FreeBetaTextStyle.h4.copyWith(
                                  color: FreeBetaColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        if (_currentSchedule.image != null)
                          _DeleteButton(day: _currentDay),
                      ],
                    ),
                  if (!_loadingImage && _currentSchedule.image != null) ...[
                    SizedBox(height: FreeBetaSizes.s),
                    ClassImage(
                      height: 300.0,
                      imageUrl: _currentSchedule.image!,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateDay(Day? day) {
    if (day == null) {
      return;
    }

    setState(() {
      _currentDay = day;
    });
  }

  Future<void> _onAddImage() async {
    var mediaApi = ref.read(mediaApiProvider);
    var imageSource = await _chooseOption(context);
    if (imageSource == null) return;

    setState(() {
      _loadingImage = true;
    });

    var imageFile = await mediaApi.fetchImage(imageSource);

    if (imageFile == null) return;

    await ref.read(classApiProvider).addDayImage(_currentDay, imageFile);

    ref.invalidate(fetchDaysProvider);

    setState(() {
      _loadingImage = false;
    });
  }

  Future<ImageSource?> _chooseOption(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) => _ImageSourceDialog(),
    );
  }
}

class _NoClasses extends StatelessWidget {
  const _NoClasses();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Row(
        children: [
          Text(
            'No classes scheduled',
            style: FreeBetaTextStyle.body4.copyWith(color: FreeBetaColors.gray),
          ),
        ],
      ),
    );
  }
}

class _EditClassRow extends StatelessWidget {
  const _EditClassRow({
    required this.classModel,
  });

  final ClassModel classModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(
            ClassFormScreen.edit(classModel),
          ),
          child: Row(
            children: [
              Expanded(
                child: ClassRow(
                  classModel: classModel,
                  darkMode: false,
                ),
              ),
              SizedBox(width: FreeBetaSizes.l),
              Icon(
                Icons.edit,
                size: FreeBetaSizes.xxl,
                color: FreeBetaColors.blueDark,
              ),
            ],
          ),
        ),
        SizedBox(height: FreeBetaSizes.m),
        FreeBetaDivider(),
      ],
    );
  }
}

class _Error extends ConsumerWidget {
  const _Error({
    Key? key,
    required this.error,
    required this.stackTrace,
  }) : super(key: key);

  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(crashlyticsApiProvider).logError(
          error,
          stackTrace,
          'EditClassesScreen',
          'getClassScheduleProvider',
        );

    return ErrorCard();
  }
}

class _Loading extends StatelessWidget {
  const _Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(),
      );
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
          child: Text(
            'Camera',
            style: FreeBetaTextStyle.h4.copyWith(
              color: FreeBetaColors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(ImageSource.camera);
          },
        ),
        ElevatedButton(
          child: Text(
            'Photos',
            style: FreeBetaTextStyle.h4.copyWith(
              color: FreeBetaColors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(ImageSource.gallery);
          },
        ),
      ],
    );
  }
}

class _DeleteButton extends ConsumerWidget {
  const _DeleteButton({
    required this.day,
  });

  final Day day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      key: Key('day-image-delete'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(FreeBetaColors.red),
        side: MaterialStateProperty.all(
          BorderSide(
            width: 2.0,
            color: FreeBetaColors.red,
          ),
        ),
      ),
      onPressed: () => _onDeletePressed(context, ref),
      child: SizedBox(
        width: 100.0,
        child: Center(
          child: Text(
            'Delete image',
            style: FreeBetaTextStyle.h4.copyWith(
              color: FreeBetaColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onDeletePressed(BuildContext context, WidgetRef ref) async {
    var willDelete = await showDialog(
      context: context,
      builder: (_) => _DeleteAreYouSureDialog(),
    );
    if (!(willDelete ?? false)) return;

    await ref.read(classApiProvider).deleteDayImage(day);

    ref.invalidate(fetchDaysProvider);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Image deleted!'),
            Spacer(),
            Icon(Icons.delete),
          ],
        ),
      ),
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
      content: Text("Are you sure you want to delete this image?"),
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

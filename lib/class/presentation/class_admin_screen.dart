import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/app/extensions/string_extensions.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/divider.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/presentation/widgets/form/dropdown_list.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/class/infrastructure/class_providers.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/infrastructure/models/class_model.p.dart';
import 'package:free_beta/class/presentation/class_form_screen.dart';
import 'package:free_beta/class/presentation/widgets/class_row.dart';

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
      body: ref.watch(fetchClassesProvider).when(
            data: (classes) => _ClassAdmin(
              classes: classes,
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
    required this.classes,
  }) : super(key: key);

  final List<ClassModel> classes;

  @override
  ConsumerState<_ClassAdmin> createState() => _ClassesAdminState();
}

class _ClassesAdminState extends ConsumerState<_ClassAdmin> {
  var _currentDay = currentDay();

  Iterable<ClassModel> get _currentDayClasses => widget.classes.activeClasses
      .where((classModel) => classModel.day == _currentDay);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: FreeBetaPadding.mAll,
        child: Column(
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
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      ClassFormScreen.add(_currentDay),
                    ),
                    child: Text('Add new class'),
                  ),
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
                  if (_currentDayClasses.isEmpty) _NoClasses(),
                  if (_currentDayClasses.isNotEmpty)
                    ..._currentDayClasses
                        .map((classModel) =>
                            _EditClassRow(classModel: classModel))
                        .toList(),
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
}

class _NoClasses extends StatelessWidget {
  const _NoClasses();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Row(
        children: [
          Text('No classes scheduled'),
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
          'fetchClassesProvider',
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

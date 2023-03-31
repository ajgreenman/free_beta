import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/app/extensions/string_extensions.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/dots.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/class/infrastructure/class_providers.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/presentation/class_chalkboard.dart';

class ClassScreen extends ConsumerWidget {
  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => ClassScreen(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: Key('class'),
      body: ref.watch(fetchClassesProvider).when(
            data: (classes) => _Schedule(classes: classes),
            error: (error, stackTrace) => _Error(
              error: error,
              stackTrace: stackTrace,
            ),
            loading: () => _Loading(),
          ),
    );
  }
}

class _Schedule extends StatefulWidget {
  const _Schedule({
    required this.classes,
  });

  final List<ClassModel> classes;

  @override
  State<_Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<_Schedule> {
  final _carouselController = CarouselController();

  var _currentDay = currentDay();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height * 0.6;
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          items: Day.values.map((day) {
            return Padding(
              padding: FreeBetaPadding.mAll,
              child: Column(
                children: [
                  Text(
                    day.name.withFirstLetterCapitalized,
                    style: FreeBetaTextStyle.h1,
                  ),
                  SizedBox(height: FreeBetaSizes.l),
                  ClassChalkboard(
                    height: _getChalkboardHeight(_height),
                    classes: widget.classes.where((c) => c.day == day).toList(),
                  ),
                ],
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: _height,
            initialPage: _currentDay.index,
            enableInfiniteScroll: true,
            onPageChanged: (index, _) {
              setState(() => _currentDay = Day.values[index]);
            },
          ),
        ),
        FreeBetaDots(
          current: _currentDay.index,
          length: Day.values.length,
        ),
        SizedBox(height: FreeBetaSizes.ml),
        Padding(
          padding: FreeBetaPadding.xxlHorizontal,
          child: Text(
            'To sign up for classes, download the RGPro Connect app or visit the website.',
            style: FreeBetaTextStyle.body3.copyWith(
              color: FreeBetaColors.grayLight,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  double _getChalkboardHeight(double availableHeight) {
    var chalkboardPadding = 32.0;
    var titleHeight = 28.0;
    var spacing = FreeBetaSizes.l;

    return availableHeight - chalkboardPadding - titleHeight - spacing;
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
          'ClassScreen',
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
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

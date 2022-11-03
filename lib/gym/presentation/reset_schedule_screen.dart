import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/gym/presentation/edit_reset_schedule_screen.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';
import 'package:intl/intl.dart';

import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/presentation/widgets/help_tooltip.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/infrastructure/gym_providers.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';

class ResetScheduleScreen extends ConsumerWidget {
  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => ResetScheduleScreen(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: Key('reset'),
      appBar: AppBar(
        title: Text('Reset Schedule'),
        leading: FreeBetaBackButton(),
        actions: [_EditButton()],
      ),
      body: ref.watch(resetScheduleProvider).when(
            data: (data) => _ResetSchedule(
              resetModel: data.first,
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

class _EditButton extends ConsumerWidget {
  const _EditButton({
    Key? key,
  }) : super(key: key);

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
        EditResetScheduleScreen.route(),
      ),
      icon: Icon(
        Icons.edit,
        color: FreeBetaColors.white,
      ),
    );
  }
}

class _ResetSchedule extends ConsumerWidget {
  const _ResetSchedule({
    Key? key,
    required this.resetModel,
  }) : super(key: key);

  final ResetModel? resetModel;

  String get _resetDateText {
    if (resetModel!.date.isToday) {
      return 'Reset TODAY ${DateFormat('MM/dd').format(resetModel!.date)}!';
    }
    return 'Next reset: ${DateFormat('MM/dd').format(resetModel!.date)}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (resetModel == null ||
        resetModel!.date.difference(DateTime.now()).inDays < 0) {
      return _EmptySchedule(
        resetModel: resetModel,
        onReset: () => _onReset(ref),
      );
    }
    return RefreshIndicator(
      onRefresh: () => _onReset(ref),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _resetDateText,
                    style: FreeBetaTextStyle.h2,
                  ),
                  SizedBox(width: FreeBetaSizes.l),
                  HelpTooltip(
                    message:
                        'The routes on the following wall sections will be removed and replaced by brand new routes at the scheduled date.',
                  ),
                ],
              ),
              SizedBox(height: FreeBetaSizes.m),
              ...WallLocation.values
                  .where((location) => resetModel!.sections
                      .any((section) => section.wallLocation == location))
                  .map(
                    (location) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.displayName,
                          style: FreeBetaTextStyle.h4,
                        ),
                        SizedBox(height: FreeBetaSizes.m),
                        WallSectionMap.static(
                          key: Key('GymMapsScreen-section-${location.name}'),
                          wallLocation: location,
                          highlightedSections: resetModel!.sections
                              .where(
                                  (section) => section.wallLocation == location)
                              .map((section) => section.wallSection)
                              .toList(),
                        ),
                        SizedBox(height: FreeBetaSizes.m),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onReset(WidgetRef ref) async {
    return ref.refresh(resetScheduleProvider);
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
          'ResetScheduleScreen',
          'resetScheduleProvider',
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

class _EmptySchedule extends ConsumerWidget {
  const _EmptySchedule({
    Key? key,
    required this.resetModel,
    required this.onReset,
  }) : super(key: key);

  final ResetModel? resetModel;
  final Future<void> Function()? onReset;

  String get _resetText => resetModel == null
      ? 'Last reset: n/a'
      : 'Last reset: ${DateFormat('MM/dd').format(resetModel!.date)}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            _resetText,
            style: FreeBetaTextStyle.h3,
          ),
          SizedBox(height: FreeBetaSizes.m),
          Text(
            'Check back soon for updates!',
            style: FreeBetaTextStyle.body4,
          ),
          SizedBox(height: FreeBetaSizes.m),
          ElevatedButton(
            onPressed: () async => ref.refresh(resetScheduleProvider),
            child: Text('Reload'),
          ),
        ],
      ),
    );
  }
}

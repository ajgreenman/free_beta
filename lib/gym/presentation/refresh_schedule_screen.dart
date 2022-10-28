import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:free_beta/gym/infrastructure/models/refresh_model.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';

class RefreshScheduleScreen extends ConsumerWidget {
  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => RefreshScheduleScreen(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: Key('refresh'),
      appBar: AppBar(
        title: Text('Refresh Schedule'),
        leading: FreeBetaBackButton(),
      ),
      body: ref.watch(refreshScheduleProvider).when(
            data: (data) => _RefreshSchedule(refreshModel: data),
            error: (error, stackTrace) => _Error(
              error: error,
              stackTrace: stackTrace,
            ),
            loading: () => _Loading(),
          ),
    );
  }
}

class _RefreshSchedule extends ConsumerWidget {
  const _RefreshSchedule({
    Key? key,
    required this.refreshModel,
  }) : super(key: key);

  final RefreshModel refreshModel;

  String get _refreshDateText {
    if (refreshModel.date.isToday()) {
      return 'Refresh TODAY ${DateFormat('MM/dd').format(refreshModel.date)}!';
    }
    return 'Next refresh: ${DateFormat('MM/dd').format(refreshModel.date)}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (refreshModel.date.difference(DateTime.now()).inDays < 0) {
      return _EmptySchedule(
        refreshModel: refreshModel,
        onRefresh: () => _onRefresh(ref),
      );
    }
    return RefreshIndicator(
      onRefresh: () => _onRefresh(ref),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _refreshDateText,
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
              ...refreshModel.sections
                  .map(
                    (section) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section.wallLocation.displayName,
                          style: FreeBetaTextStyle.h4,
                        ),
                        SizedBox(height: FreeBetaSizes.m),
                        WallSectionMap.static(
                          key: Key(
                              'GymMapsScreen-section-${section.wallLocation.name}'),
                          wallLocation: section.wallLocation,
                          highlightedSection: section.wallSection,
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

  Future<void> _onRefresh(WidgetRef ref) async {
    return ref.refresh(refreshScheduleProvider);
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
          'RefreshScheduleScreen',
          'refreshScheduleProvider',
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
    required this.refreshModel,
    required this.onRefresh,
  }) : super(key: key);

  final RefreshModel refreshModel;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Last refresh: ${DateFormat('MM/dd').format(refreshModel.date)}',
            style: FreeBetaTextStyle.h3,
          ),
          SizedBox(height: FreeBetaSizes.m),
          Text(
            'Check back soon for updates!',
            style: FreeBetaTextStyle.body4,
          ),
          SizedBox(height: FreeBetaSizes.m),
          ElevatedButton(
            onPressed: () async => ref.refresh(refreshScheduleProvider),
            child: Text('Refresh'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/presentation/widgets/help_tooltip.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/infrastructure/gym_providers.dart';
import 'package:free_beta/gym/infrastructure/models/refresh_model.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';
import 'package:intl/intl.dart';

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
      body: SingleChildScrollView(
        child: ref.watch(refreshScheduleProvider).when(
              data: (data) => _RefreshSchedule(refreshModel: data),
              error: (error, stackTrace) => _Error(
                error: error,
                stackTrace: stackTrace,
              ),
              loading: () => _Loading(),
            ),
      ),
    );
  }
}

class _RefreshSchedule extends StatelessWidget {
  const _RefreshSchedule({
    Key? key,
    required this.refreshModel,
  }) : super(key: key);

  final RefreshModel refreshModel;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Next refresh: ${DateFormat('MM/dd').format(refreshModel.date)}',
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
                    WallSectionMap(
                      key: Key(
                          'GymMapsScreen-section-${section.wallLocation.name}'),
                      wallLocation: section.wallLocation,
                      highlightedSection: section.wallSection,
                      onPressed: (_) {},
                    ),
                    SizedBox(height: FreeBetaSizes.m),
                  ],
                ),
              )
              .toList(),
        ],
      ),
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

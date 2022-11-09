import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/extensions/string_extensions.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model_extensions.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/routes/presentation/route_location_list_screen.dart';
import 'package:intl/intl.dart';

import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
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
      body: ref.watch(resetScheduleProvider).when(
            data: (data) => _ResetSchedule(
              resetSchedule: data,
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

class _ResetSchedule extends ConsumerWidget {
  const _ResetSchedule({
    Key? key,
    required this.resetSchedule,
  }) : super(key: key);

  final List<ResetModel> resetSchedule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (resetSchedule.isEmpty) {
      return _EmptySchedule(
        resetModel: null,
        onReset: () => _onRefresh(ref),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _onRefresh(ref),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _Resets(
              resets: resetSchedule.nextResets,
              onRefresh: _onRefresh,
              label: 'upcoming',
            ),
            _Resets(
              resets: resetSchedule.pastResets,
              onRefresh: _onRefresh,
              label: 'previous',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh(WidgetRef ref) async {
    return ref.refresh(resetScheduleProvider);
  }
}

class _Resets extends ConsumerWidget {
  const _Resets({
    Key? key,
    required this.resets,
    required this.onRefresh,
    required this.label,
  }) : super(key: key);

  final List<ResetModel> resets;
  final Future<void> Function(WidgetRef) onRefresh;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${label.withFirstLetterCapitalized} resets',
                style: FreeBetaTextStyle.h2,
              ),
              if (label == 'upcoming') ...[
                SizedBox(width: FreeBetaSizes.l),
                HelpTooltip(
                  message:
                      'The routes on the following wall sections will be removed and replaced by brand new routes at the scheduled date.',
                ),
              ],
            ],
          ),
          SizedBox(height: FreeBetaSizes.s),
          if (resets.isNotEmpty) ...[
            _Reset(
              resetModel: resets[0],
            ),
          ],
          if (resets.isEmpty)
            Row(
              children: [
                Text(
                  'No $label resets',
                  style: FreeBetaTextStyle.h4,
                ),
              ],
            ),
          if (resets.length > 1)
            _Reset(
              resetModel: resets[1],
            ),
        ],
      ),
    );
  }
}

class _Reset extends ConsumerWidget {
  const _Reset({
    Key? key,
    required this.resetModel,
  }) : super(key: key);

  final ResetModel resetModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          resetModel.date.stringify,
          style: FreeBetaTextStyle.h3,
        ),
        ...WallLocation.values
            .where((location) => resetModel.sections
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
                  WallSectionMap(
                    key: Key('GymMapsScreen-section-${location.name}'),
                    wallLocation: location,
                    highlightedSections: resetModel.sections
                        .where((section) => section.wallLocation == location)
                        .map((section) => section.wallSection)
                        .toList(),
                    onPressed: (index) => _onMapSectionTapped(
                      ref,
                      context,
                      index,
                      location,
                    ),
                  ),
                  SizedBox(height: FreeBetaSizes.m),
                ],
              ),
            )
            .toList(),
      ],
    );
  }

  _onMapSectionTapped(
    WidgetRef ref,
    BuildContext context,
    int index,
    WallLocation location,
  ) {
    ref.read(routeWallLocationFilterProvider.notifier).state = location;
    ref.read(routeWallLocationIndexFilterProvider.notifier).state = index;
    return Navigator.of(context).push(
      RouteLocationListScreen.route(
        wallLocation: location,
        wallLocationIndex: index,
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
            child: Text('Refresh'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/infrastructure/gym_providers.dart';
import 'package:free_beta/gym/infrastructure/models/refresh_model.dart';
import 'package:intl/intl.dart';

class EditRefreshScheduleScreen extends ConsumerWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => EditRefreshScheduleScreen());
  }

  const EditRefreshScheduleScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: Key('edit-refresh'),
      appBar: AppBar(
        title: Text('Edit Refresh Schedule'),
        leading: FreeBetaBackButton(),
      ),
      body: ref.watch(refreshScheduleProvider).when(
            data: (data) => _EditRefreshScheduleForm(refreshSchedule: data),
            error: (error, stackTrace) => _Error(
              error: error,
              stackTrace: stackTrace,
            ),
            loading: () => _Loading(),
          ),
    );
  }
}

class _EditRefreshScheduleForm extends StatelessWidget {
  const _EditRefreshScheduleForm({
    Key? key,
    required this.refreshSchedule,
  }) : super(key: key);

  final List<RefreshModel> refreshSchedule;

  RefreshModel get latestRefresh => refreshSchedule.firstWhere((refreshModel) =>
      refreshModel.date.isToday || refreshModel.date.isBeforeToday);

  List<RefreshModel> get futureRefreshes => refreshSchedule
      .where((refreshModel) => refreshModel.date.isAfterToday)
      .toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: InfoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last refresh: ${DateFormat('MM/dd').format(latestRefresh.date)}',
              style: FreeBetaTextStyle.h4,
            ),
            SizedBox(height: FreeBetaSizes.m),
            ElevatedButton(
              onPressed: () {},
              child: Text('Add new refresh'),
            ),
            SizedBox(height: FreeBetaSizes.m),
            Text(
              'Upcoming refreshes',
              style: FreeBetaTextStyle.h3,
            ),
            SizedBox(height: FreeBetaSizes.m),
            if (futureRefreshes.isEmpty)
              Text('No upcoming refreshes scheduled'),
            if (futureRefreshes.isNotEmpty)
              Text('Next refresh: ${futureRefreshes.first}'),
          ],
        ),
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
          'EditRefreshScheduleScreen',
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

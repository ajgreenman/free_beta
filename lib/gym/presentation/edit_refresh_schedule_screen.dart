import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/divider.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/infrastructure/gym_providers.dart';
import 'package:free_beta/gym/infrastructure/models/refresh_model.dart';
import 'package:free_beta/gym/infrastructure/models/refresh_model_extensions.dart';
import 'package:free_beta/gym/presentation/refresh_form_screen.dart';
import 'package:intl/intl.dart';

class EditRefreshScheduleScreen extends ConsumerWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => EditRefreshScheduleScreen());
  }

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InfoCard(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      RefreshFormScreen.add(),
                    ),
                    child: Text('Add new refresh'),
                  ),
                  if (refreshSchedule.latestRefresh != null) ...[
                    SizedBox(height: FreeBetaSizes.m),
                    FreeBetaDivider(),
                    _LatestRefreshRow(
                      latestRefresh: refreshSchedule.latestRefresh!,
                    ),
                    FreeBetaDivider(),
                  ],
                ],
              ),
            ),
          ),
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upcoming refreshes',
                  style: FreeBetaTextStyle.h3,
                ),
                SizedBox(height: FreeBetaSizes.m),
                if (refreshSchedule.futureRefreshes.isEmpty) ...[
                  FreeBetaDivider(),
                  _NoUpcoming(),
                ],
                if (refreshSchedule.futureRefreshes.isNotEmpty) ...[
                  FreeBetaDivider(),
                  ...refreshSchedule.futureRefreshes.map(
                    (refresh) => _RefreshRow(refreshModel: refresh),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LatestRefreshRow extends StatelessWidget {
  const _LatestRefreshRow({
    Key? key,
    required this.latestRefresh,
  }) : super(key: key);

  final RefreshModel latestRefresh;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        RefreshFormScreen.edit(latestRefresh),
      ),
      child: SizedBox(
        height: 48.0,
        child: Row(
          children: [
            Text(
              'Last refresh: ${DateFormat('MM/dd').format(latestRefresh.date)}',
              style: FreeBetaTextStyle.h4,
            ),
            Spacer(),
            Icon(
              Icons.edit,
              size: FreeBetaSizes.xxl,
              color: FreeBetaColors.blueDark,
            ),
          ],
        ),
      ),
    );
  }
}

class _NoUpcoming extends StatelessWidget {
  const _NoUpcoming({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Row(
        children: [
          Text('No upcoming refreshes scheduled'),
        ],
      ),
    );
  }
}

class _RefreshRow extends StatelessWidget {
  const _RefreshRow({
    Key? key,
    required this.refreshModel,
  }) : super(key: key);

  final RefreshModel refreshModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(
            RefreshFormScreen.edit(refreshModel),
          ),
          child: SizedBox(
            height: 48.0,
            child: Row(
              children: [
                Text(
                  DateFormat('MM/dd').format(refreshModel.date),
                  style: FreeBetaTextStyle.body3,
                ),
                Padding(
                  padding: FreeBetaPadding.sHorizontal,
                  child: Text(
                    '|',
                    style: FreeBetaTextStyle.body3
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${refreshModel.sections.length} sections',
                  style: FreeBetaTextStyle.body3,
                ),
                Spacer(),
                Icon(
                  Icons.edit,
                  size: FreeBetaSizes.xxl,
                  color: FreeBetaColors.blueDark,
                ),
              ],
            ),
          ),
        ),
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

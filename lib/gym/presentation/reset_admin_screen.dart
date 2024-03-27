import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/extensions/extensions.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/divider.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/infrastructure/gym_providers.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model_extensions.dart';
import 'package:free_beta/gym/presentation/reset_form_screen.dart';
import 'package:intl/intl.dart';

class ResetAdminScreen extends ConsumerWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => ResetAdminScreen());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: Key('edit-reset'),
      appBar: AppBar(
        title: Text('Edit Reset Schedule'),
        leading: FreeBetaBackButton(),
      ),
      body: ref.watch(resetScheduleProvider).when(
            data: (resetSchedule) => _ResetAdmin(
              resetSchedule: resetSchedule,
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

class _ResetAdmin extends StatelessWidget {
  const _ResetAdmin({
    Key? key,
    required this.resetSchedule,
  }) : super(key: key);

  final List<ResetModel> resetSchedule;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _AddReset(
            latestReset: resetSchedule.latestReset,
          ),
          _Resets(
            resets: resetSchedule.nextResets,
            label: 'upcoming',
            length: 2,
          ),
          _Resets(
            resets: resetSchedule.pastResets,
            label: 'previous',
            length: 4,
          ),
        ],
      ),
    );
  }
}

class _AddReset extends StatelessWidget {
  const _AddReset({
    required this.latestReset,
  });

  final ResetModel? latestReset;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                ResetFormScreen.add(),
              ),
              child: Text(
                'Add new reset',
                style: FreeBetaTextStyle.h4.copyWith(
                  color: FreeBetaColors.white,
                ),
              ),
            ),
            if (latestReset != null) ...[
              SizedBox(height: FreeBetaSizes.m),
              FreeBetaDivider(),
              _LatestResetRow(
                latestReset: latestReset!,
              ),
              FreeBetaDivider(),
            ],
          ],
        ),
      ),
    );
  }
}

class _Resets extends StatelessWidget {
  const _Resets({
    required this.resets,
    required this.label,
    required this.length,
  });

  final List<ResetModel> resets;
  final String label;
  final int length;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${label.withFirstLetterCapitalized} resets',
            style: FreeBetaTextStyle.h3,
          ),
          SizedBox(height: FreeBetaSizes.m),
          FreeBetaDivider(),
          if (resets.isEmpty)
            _NoUpcoming(
              label: label,
            ),
          if (resets.isNotEmpty)
            ...resets.take(length).map(
                  (reset) => _ResetRow(resetModel: reset),
                ),
        ],
      ),
    );
  }
}

class _LatestResetRow extends StatelessWidget {
  const _LatestResetRow({
    Key? key,
    required this.latestReset,
  }) : super(key: key);

  final ResetModel latestReset;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        ResetFormScreen.edit(latestReset),
      ),
      child: SizedBox(
        height: 48.0,
        child: Row(
          children: [
            Text(
              'Last reset: ${DateFormat('MM/dd').format(latestReset.date)}',
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
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Row(
        children: [
          Text('No $label resets scheduled'),
        ],
      ),
    );
  }
}

class _ResetRow extends StatelessWidget {
  const _ResetRow({
    Key? key,
    required this.resetModel,
  }) : super(key: key);

  final ResetModel resetModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(
            ResetFormScreen.edit(resetModel),
          ),
          child: SizedBox(
            height: 48.0,
            child: Row(
              children: [
                Text(
                  DateFormat('MM/dd').format(resetModel.date),
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
                  '${resetModel.sections.length} sections',
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
          'EditResetScheduleScreen',
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

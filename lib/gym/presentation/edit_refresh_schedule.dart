import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';

class EditRefreshSchedule extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return EditRefreshSchedule();
    });
  }

  const EditRefreshSchedule({super.key});

  @override
  State<EditRefreshSchedule> createState() => _EditRefreshScheduleState();
}

class _EditRefreshScheduleState extends State<EditRefreshSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('add-refresh'),
      appBar: AppBar(
        title: Text('Add Refresh'),
        leading: FreeBetaBackButton(),
      ),
      body: Text('edit refresh'),
    );
  }
}

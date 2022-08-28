import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/route_form.dart';

class CreateRouteScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return CreateRouteScreen();
    });
  }

  const CreateRouteScreen({Key? key}) : super(key: key);

  @override
  State<CreateRouteScreen> createState() => _CreateRouteScreenState();
}

class _CreateRouteScreenState extends State<CreateRouteScreen> {
  bool _dirtyForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('create-route'),
      appBar: AppBar(
        title: Text('Create Route'),
        leading: FreeBetaBackButton(onPressed: _onBack),
      ),
      body: RouteForm(
        setDirtyForm: () => setState(() => _dirtyForm = true),
      ),
    );
  }

  void _onBack() async {
    if (!_dirtyForm) {
      Navigator.of(context).pop();
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => _AreYouSureDialog(),
    );
  }
}

class _AreYouSureDialog extends StatelessWidget {
  const _AreYouSureDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Text("You have unsaved changes, are you sure you want to exit?"),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            textAlign: TextAlign.end,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(width: FreeBetaSizes.s),
        TextButton(
          child: Text(
            'Exit',
            textAlign: TextAlign.end,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

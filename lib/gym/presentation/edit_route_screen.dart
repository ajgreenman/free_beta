import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/route_form.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';

class EditRouteScreen extends ConsumerStatefulWidget {
  static Route<dynamic> route(RouteModel routeModel) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return EditRouteScreen(routeModel: routeModel);
    });
  }

  const EditRouteScreen({
    Key? key,
    required this.routeModel,
  }) : super(key: key);

  final RouteModel routeModel;

  @override
  _EditRouteScreenState createState() => _EditRouteScreenState();
}

class _EditRouteScreenState extends ConsumerState<EditRouteScreen> {
  bool _dirtyForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('edit-route'),
      appBar: AppBar(
        title: Text('Edit Route'),
        leading: FreeBetaBackButton(onPressed: _onBack),
        actions: [_buildDeleteButton(context, ref)],
      ),
      body: RouteForm(
        editRouteModel: widget.routeModel,
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
      builder: (_) => _SaveAreYouSureDialog(),
    );
  }

  Widget _buildDeleteButton(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => _onDeletePressed(context, ref),
      icon: Icon(
        Icons.delete,
        color: FreeBetaColors.white,
      ),
    );
  }

  Future<void> _onDeletePressed(BuildContext context, WidgetRef ref) async {
    var willDelete = await showDialog(
      context: context,
      builder: (_) => _DeleteAreYouSureDialog(),
    );
    if (!willDelete) return;

    await ref.read(routeApiProvider).deleteRoute(
          widget.routeModel,
        );
    ref.refresh(fetchRoutesProvider);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Route deleted!'),
            Spacer(),
            Icon(Icons.delete),
          ],
        ),
      ),
    );
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}

class _SaveAreYouSureDialog extends StatelessWidget {
  const _SaveAreYouSureDialog({
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

class _DeleteAreYouSureDialog extends StatelessWidget {
  const _DeleteAreYouSureDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Are you sure you want to delete this route?"),
          SizedBox(height: FreeBetaSizes.m),
          Text(
              "Deleting a route means it won't show up on the Removed Routes screen. Instead, to remove a route, simply set a Removal Date."),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text('Delete'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}

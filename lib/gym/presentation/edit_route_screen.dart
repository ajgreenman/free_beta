import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/gym/presentation/route_form.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

class EditRouteScreen extends StatelessWidget {
  static Route<dynamic> route(RouteModel routeModel) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return EditRouteScreen(routeModel: routeModel);
    });
  }

  final RouteModel routeModel;

  const EditRouteScreen({Key? key, required this.routeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('edit-route'),
      appBar: AppBar(
        title: Text('Edit Route'),
        leading: FreeBetaBackButton(),
      ),
      body: RouteForm(
        editRouteModel: routeModel,
      ),
    );
  }
}

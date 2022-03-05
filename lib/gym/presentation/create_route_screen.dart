import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/gym/presentation/create_route_form.dart';

class CreateRouteScreen extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return CreateRouteScreen();
    });
  }

  const CreateRouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('create-route'),
      appBar: AppBar(
        title: Text('Create Route'),
        leading: FreeBetaBackButton(),
      ),
      body: CreateRouteForm(),
    );
  }
}

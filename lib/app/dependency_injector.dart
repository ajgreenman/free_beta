import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_beta/routes/cubit/route_cubit.dart';
import 'package:free_beta/routes/route_dependencies.dart';
import 'package:free_beta/routes/infrastructure/route_service_facade.dart';
import 'package:provider/provider.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...RouteDomain.dependencies,
      ],
      child: child,
    );
  }
}

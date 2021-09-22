import 'package:flutter/material.dart';
import 'package:free_beta/routes/route_dependencies.dart';
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

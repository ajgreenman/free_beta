import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_beta/routes/cubit/route_cubit.dart';

class Initalizer extends StatefulWidget {
  final Widget child;
  const Initalizer({Key? key, required this.child}) : super(key: key);

  @override
  _InitalizerState createState() => _InitalizerState();
}

class _InitalizerState extends State<Initalizer> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<RouteCubit>(context).getRoutes();
  }

  @override
  Widget build(_) => widget.child;
}

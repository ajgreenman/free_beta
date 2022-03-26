import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

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
  }

  @override
  Widget build(_) => ProviderScope(child: _Initializer(child: widget.child));
}

class _Initializer extends ConsumerWidget {
  const _Initializer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fetchRoutesProvider);
    return child;
  }
}

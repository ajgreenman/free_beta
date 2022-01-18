import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Widget build(_) => ProviderScope(child: widget.child);
}

import 'package:flutter/material.dart';
import 'package:free_beta/app/free_beta.dart';
import 'package:free_beta/app/initializer.dart';
import 'package:free_beta/app/theme.dart';

void main() {
  runApp(
    Initalizer(
      child: MaterialApp(
        title: 'Free Beta',
        theme: FreeBetaTheme.blueTheme,
        home: FreeBeta(),
      ),
    ),
  );
}

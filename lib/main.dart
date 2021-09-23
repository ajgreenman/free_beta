import 'package:flutter/material.dart';
import 'package:free_beta/app/free_beta.dart';
import 'package:free_beta/app/initializer.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/app/dependency_injector.dart';

void main() {
  runApp(
    DependencyInjector(
      child: Initalizer(
        child: MaterialApp(
          title: 'Free Beta',
          theme: FreeBetaTheme.blueTheme,
          home: FreeBeta(),
        ),
      ),
    ),
  );
}

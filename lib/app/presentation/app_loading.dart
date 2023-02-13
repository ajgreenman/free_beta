import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/logo_spinner.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    Key? key,
    required this.onComplete,
  }) : super(key: key);

  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: onComplete,
        child: SafeArea(
          child: Center(
            child: LogoSpinner(onComplete: onComplete),
          ),
        ),
      ),
    );
  }
}

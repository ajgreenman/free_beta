import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/logo_spinner.dart';

class AppLoading extends StatefulWidget {
  const AppLoading({
    Key? key,
    required this.onComplete,
  }) : super(key: key);

  final VoidCallback onComplete;

  @override
  State<AppLoading> createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: widget.onComplete,
        child: SafeArea(
          child: Center(
            child: LogoSpinner(onComplete: widget.onComplete),
          ),
        ),
      ),
    );
  }
}

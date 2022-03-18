import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/logo_spinner.dart';
import 'package:free_beta/app/theme.dart';

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
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: _SkipButton(onPressed: widget.onComplete),
            ),
            LogoSpinner(onComplete: widget.onComplete),
          ],
        ),
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FreeBetaPadding.mAll,
      child: TextButton(
        onPressed: onPressed,
        child: Text('Skip'),
      ),
    );
  }
}

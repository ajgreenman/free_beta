import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/user/presentation/contact_developer_screen.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact',
            style: FreeBetaTextStyle.h2,
          ),
          SizedBox(height: FreeBetaSizes.l),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () =>
              Navigator.of(context).push(ContactDeveloperScreen.route()),
          child: Padding(
            padding: FreeBetaPadding.xlHorizontal,
            child: Text(
              'Contact Developer',
              style: FreeBetaTextStyle.h4.copyWith(
                color: FreeBetaColors.white,
              ),
            ),
          ),
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                width: 2,
              ),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                vertical: FreeBetaSizes.ml,
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}

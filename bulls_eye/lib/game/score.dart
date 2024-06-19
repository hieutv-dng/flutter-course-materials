import 'package:bulls_eye/text_styles.dart';
import 'package:flutter/material.dart';
import '../about/about_page.dart';
import '../styled_button.dart';

class Score extends StatelessWidget {
  const Score({
    super.key,
    required this.totalScore,
    required this.round,
    required this.onStartOver,
  });

  final int totalScore;
  final int round;
  final VoidCallback onStartOver;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StyledButton(
          onPressed: () {
            onStartOver();
          },
          icon: Icons.refresh,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Text(
                'Score:',
                style: LabelTextStyle.bodyMedium(context),
              ),
              Text(
                '$totalScore',
                style: ScoreNumberTextStyle.headlineSmall(context),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Text(
                'Round:',
                style: LabelTextStyle.bodyMedium(context),
              ),
              Text(
                '$round',
                style: ScoreNumberTextStyle.headlineSmall(context),
              ),
            ],
          ),
        ),
        StyledButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            );
          },
          icon: Icons.info,
        ),
      ],
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

import 'control.dart';
import 'game_model.dart';
import 'hit_me_button.dart';
import 'prompt.dart';
import 'score.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(_newTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Prompt(targetValue: _model.target),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Control(model: _model),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: HitMeButton(
                  onPressed: () {
                    _showAlert();
                  },
                  text: 'HIT ME',
                ),
              ),
              Score(
                totalScore: _model.totalScore,
                round: _model.round,
                onStartOver: _startNewGame,
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _pointsForCurrentRound() {
    const int maximumScore = 100;
    int diffence = _differenceAmount();
    int bonus = 0;
    if (diffence == 0) {
      bonus = 100;
    } else if (diffence == 1) {
      bonus = 50;
    }
    return maximumScore - diffence + bonus;
  }

  String _alertTitle() {
    int diffence = _differenceAmount();
    if (diffence == 0) {
      return 'Hoàn hảo!';
    } else if (diffence < 5) {
      return 'Bạn suýt nữa đã làm được!';
    } else if (diffence <= 10) {
      return 'Không tệ!';
    } else {
      return 'Bạn có đang chơi không vậy?';
    }
  }

  int _newTargetValue() => Random().nextInt(100) + 1;

  int _differenceAmount() => (_model.target - _model.current).abs();

  void _startNewGame() {
    setState(() {
      _model.totalScore = GameModel.scoreStart;
      _model.round = GameModel.roundStart;
      _model.current = GameModel.sliderStart;
      _model.target = _newTargetValue();
    });
  }

  void _showAlert() {
    var okButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          _model.totalScore += _pointsForCurrentRound();
          _model.target = _newTargetValue();
          _model.round += 1;
        });
      },
      child: const Text('Awesome'),
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_alertTitle()),
          content: Text('Giá trị của thanh trượt là ${_model.current}\n'
              'Bạn đã ghi được ${_pointsForCurrentRound()} điểm trong vòng này.'),
          actions: [
            okButton,
          ],
          elevation: 10,
        );
      },
    );
  }
}

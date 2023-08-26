import 'package:flutter/material.dart';
import 'package:pong_game/models/ball_model.dart';
import 'package:pong_game/models/bat_model.dart';
import 'moving_ball.dart';
import 'moving_bat.dart';

double screenHeight = 0;
double screenWidth = 0;

class Pong extends StatefulWidget {
  const Pong({super.key});

  @override
  State<Pong> createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  late BatModel batModel;
  late BallModel ballModel;
  late Animation<double> animation;
  late AnimationController controller;
  int score = 0;

  @override
  void initState() {
    super.initState();
    batModel = BatModel();
    ballModel = BallModel();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 10000),
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controller);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void showGameOverMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('Would you like to play again'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    ballModel.reset();
                    score = 0;
                  });
                  Navigator.of(context).pop();
                  controller.repeat();
                },
                child: Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      screenHeight = constraints.maxHeight;
      screenWidth = constraints.maxWidth;
      if (batModel.height == 0) {
        batModel.height = screenHeight / 15;
        batModel.width = screenWidth / 5;
        batModel.position = screenWidth / 2 - batModel.width / 2;
      }

      if (ballModel.diameter == 0) {
        ballModel.diameter = screenHeight / 20;
      }
      return Stack(
        children: [
          Positioned(
            top: 0,
            right: 24,
            child: Text('Score : $score'),
          ),
          MovingBall(
            ballModel: ballModel,
            animation: animation,
            checkBorders: () {
              ballModel.checkBorders(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  bat: batModel,
                  controller: controller,
                  addScore: () {
                    setState(() {
                      ++score;
                    });
                  },
                  showGameEnd: showGameOverMessage);
            },
          ),
          MovingBat(batModel: batModel)
        ],
      );
    });
  }
}

import 'dart:math';

import 'package:flutter/animation.dart';

import 'bat_model.dart';
import 'enums.dart';

class BallModel {
  double posX = 0;
  double posY = 0;
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;
  double diameter = 0;
  double randX = 1;
  double randY = 1;

  double randomNumber() {
    Random ran = Random();
    int myNum = ran.nextInt(101);
    return (50 + myNum) / 100;
  }

  void checkBorders(
      {required double screenWidth,
      required double screenHeight,
      required BatModel bat,
      required AnimationController controller,
      required Function addScore,
      required Function showGameEnd}) {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= screenWidth - diameter && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    if (posY >= screenHeight - diameter - bat.height &&
        vDir == Direction.down) {
      if (posX >= (bat.position - diameter) &&
          posX <= (bat.position + bat.width + diameter)) {
        vDir = Direction.up;
        randY = randomNumber();
        addScore();
      } else {
        controller.stop();
        showGameEnd();
      }
    }
    if (posY <= 0 && vDir == Direction.up) {
      randY = randomNumber();
      vDir = Direction.down;
    }
  }

  void reset() {
    posX = 0;
    posY = 0;
  }
}

import 'package:flutter/material.dart';
import 'package:pong_game/models/ball_model.dart';

class BallWidget extends StatelessWidget {
  const BallWidget({
    super.key,
    required this.model,
  });
  final BallModel model;


  @override
  Widget build(BuildContext context) {

    return Container(
      height: model.diameter,
      width: model.diameter,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
    );
  }
}

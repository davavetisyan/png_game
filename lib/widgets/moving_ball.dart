import 'package:flutter/material.dart';
import '../models/ball_model.dart';
import '../models/enums.dart';
import 'ball_widget.dart';

class MovingBall extends StatefulWidget {
  const MovingBall({
    super.key,
    required this.ballModel,
    required this.animation,
    required this.checkBorders,
  });

  final BallModel ballModel;
  final Animation animation;
  final Function checkBorders;

  @override
  State<MovingBall> createState() => _MovingBallState();
}

class _MovingBallState extends State<MovingBall> {
  double ballSpeed = 5;

  @override
  void initState() {
    widget.animation.addListener(() {
      setState(() {
        (widget.ballModel.hDir == Direction.right)
            ? widget.ballModel.posX +=
                (ballSpeed * widget.ballModel.randX.round())
            : widget.ballModel.posX -=
                (ballSpeed * widget.ballModel.randX.round());
        (widget.ballModel.vDir == Direction.down)
            ? widget.ballModel.posY +=
                (ballSpeed * widget.ballModel.randY.round())
            : widget.ballModel.posY -=
                (ballSpeed * widget.ballModel.randY.round());
      });
      widget.checkBorders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.ballModel.posY,
      left: widget.ballModel.posX,
      child: BallWidget(
        model: widget.ballModel,
      ),
    );
  }
}

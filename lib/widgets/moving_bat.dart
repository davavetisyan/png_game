import 'package:flutter/material.dart';

import '../models/bat_model.dart';
import 'bat_widget.dart';

class MovingBat extends StatefulWidget {
  const MovingBat({
    super.key,
    required this.batModel,
  });

  final BatModel batModel;

  @override
  State<MovingBat> createState() => _MovingBatState();
}

class _MovingBatState extends State<MovingBat> {
  void moveBat(DragUpdateDetails details) {
    setState(() {
      widget.batModel.position += details.delta.dx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: widget.batModel.position,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          moveBat(details);
        },
        child: BatWidget(
          bat: widget.batModel,
        ),
      ),
    );
  }
}

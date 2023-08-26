import 'package:flutter/material.dart';
import 'package:pong_game/models/bat_model.dart';

class BatWidget extends StatelessWidget {
  const BatWidget({
    super.key,
    required this.bat,
  });
  final BatModel bat;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: bat.height,
      width: bat.width,
    );
  }
}

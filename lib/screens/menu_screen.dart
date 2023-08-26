import 'package:flutter/material.dart';
import 'package:pong_game/models/enums.dart';
import 'package:pong_game/screens/pong_grid.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'Simple Pong Game',
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
        body: Stack(children: [
          MenuMovingBall(
            startPosX: 0,
            startPosY: 0,
            ballColor: Colors.deepPurple,
          ),
          MenuMovingBall(
            startPosX: MediaQuery.of(context).size.width,
            startPosY: 0,
            ballColor: Colors.amberAccent,
          ),
          MenuMovingBall(
            startPosX: MediaQuery.of(context).size.width,
            startPosY: MediaQuery.of(context).size.height,
            ballColor: Colors.lightBlueAccent,
          ),
          MenuMovingBall(
            startPosX: 0,
            startPosY: MediaQuery.of(context).size.height,
            ballColor: Colors.red,
          ),
          MenuMovingBall(
            startPosX: MediaQuery.of(context).size.width / 2,
            startPosY: 0,
            ballColor: Colors.green,
          ),
          MenuMovingBall(
            startPosX: MediaQuery.of(context).size.width / 2,
            startPosY: MediaQuery.of(context).size.height,
            ballColor: Colors.green,
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Pong();
                      }));
                    },
                    child: const Text(
                      'New Game',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class MenuMovingBall extends StatefulWidget {
  const MenuMovingBall({
    super.key,
    required this.ballColor,
    required this.startPosX,
    required this.startPosY,
  });

  final double startPosY;
  final double startPosX;
  final Color ballColor;

  @override
  State<MenuMovingBall> createState() => _MenuMovingBallState();
}

class _MenuMovingBallState extends State<MenuMovingBall>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation moveAnimation;
  Direction hDir = Direction.right;

  Direction vDir = Direction.up;
  double posX = 0;
  double posY = 0;
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  void initState() {
    posX = widget.startPosX;
    posY = widget.startPosY;
    controller =
        AnimationController(vsync: this, duration: Duration(minutes: 5000));
    moveAnimation = Tween<double>(begin: 0, end: 100).animate(controller);
    controller.addListener(() {
      if (mounted) {
        setState(() {
          (hDir == Direction.right) ? posX += 5 : posX -= 5;

          (vDir == Direction.down) ? posY += 5 : posY -= 5;
        });
        checkBorders();
      }
    });
    controller.forward();
    super.initState();
  }

  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
    }
    if (posX >= screenWidth - screenHeight / 20 && hDir == Direction.right) {
      hDir = Direction.left;
    }
    if (posY >= screenHeight - screenHeight / 20 && vDir == Direction.down) {
      vDir = Direction.up;
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (screenHeight == 0) {
      screenHeight = MediaQuery.of(context).size.height;

      screenWidth = MediaQuery.of(context).size.width;
    }
    return Positioned(
        top: posY,
        left: posX,
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (vDir == Direction.up) {
                vDir = Direction.down;
              } else {
                vDir = Direction.up;
              }

              if (hDir == Direction.left) {
                hDir = Direction.right;
              } else {
                hDir = Direction.left;
              }
            });
          },
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                height: screenHeight / 20,
                width: screenHeight / 20,
                decoration: BoxDecoration(
                  color: widget.ballColor,
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        ));
  }
}

/* Developed By Eng Mouaz M. AlShahmeh */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_mario_flutter_game/button.dart';
import 'package:super_mario_flutter_game/jumpingmario.dart';
import 'package:super_mario_flutter_game/mario.dart';
import 'package:super_mario_flutter_game/mushroom.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double mushroomX = 0.5;
  double mushroomY = 1;
  double marioSize = 50;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = 'right';
  bool midRun = true;
  bool midJump = false;
  TextStyle gameFont = GoogleFonts.pressStart2p(
    textStyle: const TextStyle(color: Colors.white, fontSize: 20),
  );
  static double blockX = -0.3;
  static double blockY = 0.3;
  double moneyX = blockX;
  double moneyY = blockY;
  int money = 0;

  void checkIfAteMushroom() {
    if ((marioX - mushroomX).abs() < 0.05 &&
        (marioY - mushroomY).abs() < 0.05) {
      setState(() {
        mushroomX = 2;
        marioSize = 100;
      });
    }
  }

  void releaseMoney() {
    money++;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        moneyY -= 0.1;
      });
      if (moneyY < -1) {
        timer.cancel();
        moneyY = blockY;
      }
    });
  }

  void fall() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        marioY += 0.05;
      });
      if (marioY > 1) {
        marioY = 1;
        timer.cancel();
        midJump = false;
      }
    });
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    if (midJump == false) {
      midJump = true;
      preJump();
      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        if ((marioX - blockX).abs() < 0.05 && (marioY - blockY).abs() < 0.3) {
          fall();
          releaseMoney();
          timer.cancel();
        } else if ((marioX - blockX).abs() < 0.05 && (marioY - blockY) < 0.3) {
          midJump = false;
          setState(() {
            marioY = marioSize == 50 ? -0.05 : -0.25;
          });
          timer.cancel();
        } else {
          time += 0.05;
          height = -4.9 * time * time + 5 * time;
          if (initialHeight - height > 1) {
            midJump = false;
            setState(() {
              marioY = 1;
            });
            timer.cancel();
          } else {
            setState(() {
              marioY = initialHeight - height;
            });
          }
        }
      });
    }
  }

  void moveRight() {
    direction = 'right';
    checkIfAteMushroom();
    if ((marioX - blockX).abs() > 0.09) {
      fall();
    }
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (const IButton().userIsHoldingButton() == true &&
          (marioX + 0.02) < 1) {
        setState(() {
          marioX += 0.02;
          midRun = !midRun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = 'left';
    checkIfAteMushroom();
    if ((marioX - blockX).abs() > 0.09) {
      fall();
    }
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (const IButton().userIsHoldingButton() == true &&
          (marioX - 0.02) > -1) {
        setState(() {
          marioX -= 0.02;
          midRun = !midRun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  color: Colors.blue,
                  child: AnimatedContainer(
                    alignment: Alignment(marioX, marioY),
                    duration: const Duration(milliseconds: 0),
                    child: midJump
                        ? JumpingMario(
                            direction: direction,
                            size: marioSize,
                          )
                        : IMario(
                            direction: direction,
                            midRun: midRun,
                            size: marioSize,
                          ),
                  ),
                ),
                Container(
                  alignment: Alignment(moneyX, moneyY),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      color: Colors.orange,
                      child: const Icon(
                        Icons.attach_money,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment(blockX, blockY),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.brown,
                      child: const Icon(
                        Icons.question_mark,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment(mushroomX, mushroomY),
                  child: const IMushroom(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'MARIO',
                            style: gameFont,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$money',
                            style: gameFont,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'WORLD',
                            style: gameFont,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '1-1',
                            style: gameFont,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'TIME',
                            style: gameFont,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '9999',
                            style: gameFont,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IButton(
                    function: moveLeft,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  IButton(
                    function: jump,
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                  ),
                  IButton(
                    function: moveRight,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

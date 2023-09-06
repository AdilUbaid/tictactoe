import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayX0 = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  String resultDeclaration = '';
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerfound = false;
  Timer? timer;
  static const maxSecond = 30;
  int seconds = maxSecond;
  int attempts = 0;

  static var customFontWhite = GoogleFonts.coiny(
      textStyle:
          const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 28));

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSecond;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Player O",
                                style: customFontWhite,
                              ),
                              Text(
                                oScore.toString(),
                                style: customFontWhite,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Player X",
                                style: customFontWhite,
                              ),
                              Text(
                                xScore.toString(),
                                style: customFontWhite,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 3,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          _tapped(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 5, color: MainColor.primaryColor),
                            color: MainColor.secondaryColor,
                          ),
                          child: Center(
                            child: Text(
                              displayX0[index],
                              style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                      fontSize: 64,
                                      color: MainColor.primaryColor)),
                            ),
                          ),
                        ),
                      ),
                      itemCount: 9,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              resultDeclaration,
                              style: customFontWhite,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildTimer(),
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (oTurn && displayX0[index] == '') {
          displayX0[index] = 'O';
          filledBoxes++;
        } else if (!oTurn && displayX0[index] == '') {
          displayX0[index] = 'X';
          filledBoxes++;
        }
        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    //row 1
    if (displayX0[0] == displayX0[1] &&
        displayX0[0] == displayX0[2] &&
        displayX0[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[0] + ' wins';
      });
      _updateScore(displayX0[0]);
    } //row 2
    if (displayX0[3] == displayX0[4] &&
        displayX0[3] == displayX0[5] &&
        displayX0[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[3] + ' wins';
      });
      _updateScore(displayX0[3]);
    } //row 3
    if (displayX0[6] == displayX0[7] &&
        displayX0[6] == displayX0[8] &&
        displayX0[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[6] + ' wins';
      });
      _updateScore(displayX0[6]);
    }
    //column 1
    if (displayX0[0] == displayX0[3] &&
        displayX0[0] == displayX0[6] &&
        displayX0[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[0] + ' wins';
      });
      _updateScore(displayX0[0]);
    } //column 2
    if (displayX0[1] == displayX0[4] &&
        displayX0[1] == displayX0[7] &&
        displayX0[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[1] + ' wins';
      });
      _updateScore(displayX0[1]);
    } //column 3
    if (displayX0[2] == displayX0[5] &&
        displayX0[2] == displayX0[8] &&
        displayX0[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[2] + ' wins';
      });
      _updateScore(displayX0[2]);
    }
    //diagonal 1
    if (displayX0[0] == displayX0[4] &&
        displayX0[0] == displayX0[8] &&
        displayX0[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[0] + ' wins';
      });
      _updateScore(displayX0[0]);
    }
    //diagonal 2
    if (displayX0[2] == displayX0[4] &&
        displayX0[2] == displayX0[6] &&
        displayX0[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[2] + ' wins';
      });
      _updateScore(displayX0[2]);
    }
    if (!winnerfound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = "Nobody wins";
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == "O") {
      oScore++;
    } else if (winner == "X") {
      xScore++;
    }
    winnerfound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayX0[i] = '';
      }
      resultDeclaration = '';
    });
    filledBoxes = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSecond,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: MainColor.accentColor,
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 50),
                  ),
                )
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            onPressed: () {
              startTimer();
              _clearBoard();
              attempts++;
            },
            child: Text(
              attempts == 0 ? "Start" : "Play again",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ));
  }
}

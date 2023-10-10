import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSecond = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomodors = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSecond == 0) {
      setState(() {
        isRunning = false;
        totalSecond = twentyFiveMinutes;
        totalPomodors++;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSecond--;
      });
    }
  }

  void onStartPress() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onStopPress() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void reset() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSecond = twentyFiveMinutes;
    });
  }

  String formatting(int second) {
    var duration = Duration(seconds: second);
    List<String> list = duration.toString().split(".")[0].split(":");
    return "${list[1]}:${list[2]}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                formatting(totalSecond),
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 70,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: IconButton(
                      iconSize: 110,
                      color: Theme.of(context).cardColor,
                      onPressed: isRunning ? onStopPress : onStartPress,
                      icon: Icon(
                        isRunning ? Icons.stop_circle : Icons.play_circle,
                      )),
                ),
                Center(
                  child: GestureDetector(
                    onTap: reset,
                    child: const Text("Reset",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            fontSize: 25,
                            color:
                                // ignore: deprecated_member_use
                                Theme.of(context).textTheme.headline1!.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$totalPomodors',
                          style: TextStyle(
                            fontSize: 40,
                            color:
                                // ignore: deprecated_member_use
                                Theme.of(context).textTheme.headline1!.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

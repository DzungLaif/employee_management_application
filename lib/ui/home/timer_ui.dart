import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerCounter extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<TimerCounter> {
  double percent = 0;
  String accuracy = "0.0%";
  static double timeInMilis =
      (3600.0) * 1000; // Hard code, data will be fetched from database later.

  String timeRoot =
      "01:00:00"; // Reverse variable for timeToDisplay when it may not change at the last milisecond of UI updating
  String timeToDisplay =
      "01:00:00"; // Hard code, data will be fetched from database later.
  String buttonText = 'Start';
  bool stopWatchIsRunning = false;
  Timer timer;
  var swatch = Stopwatch();

  // function when press start button
  _startStopwatch() {
    setState(() {
      swatch.reset();
      stopWatchIsRunning = true;
      buttonText = 'Finish';
      percent = 0;
    });

    swatch.start();
    timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      if (swatch.elapsedMilliseconds <= timeInMilis) {
        setState(() {
          // Handle CircularPercentIndicator percent bar
          if (percent < 1)
            percent = swatch.elapsedMilliseconds / timeInMilis;
          else
            percent = 1;
          // Handle accuracy number
          accuracy = ((swatch.elapsedMilliseconds * 100) / timeInMilis)
                  .toStringAsFixed(1) +
              "%";
          // Handle text inside CircularPercentIndicator percent bar
          timeToDisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
              ":" +
              (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
              ":" +
              (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
        });
      } else {
        timeToDisplay = timeRoot;
        _finishStopWatch();
      }
    });
  }

  // function when press finish button
  _finishStopWatch() {
    setState(() {
      stopWatchIsRunning = false;
      buttonText = 'Start';
    });
    swatch.stop();
    timer.cancel();
  }

  // stopWatch Controller
  _stopWatchController() {
    if (stopWatchIsRunning == false && swatch.elapsed.inMinutes < timeInMilis) {
      _startStopwatch();
    } else if (stopWatchIsRunning == true) {
      _finishStopWatch();
    }
  }

  // Timer UI
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OrientationBuilder(builder: (_, orientation) {
          // Potrait UI
          if (orientation == Orientation.portrait) {
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff1542bf), Color(0xff51a8ff)],
                begin: FractionalOffset(0.5, 1),
              )),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment(0.0, 1.3),
                      child: CircularPercentIndicator(
                        circularStrokeCap: CircularStrokeCap.round,
                        percent: percent,
                        animation: true,
                        animateFromLastPercent: true,
                        radius: 250.0,
                        lineWidth: 15,
                        progressColor: Colors.white,
                        center: Text(
                          timeToDisplay,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Padding(
                    padding: EdgeInsets.only(top: 18.0),
                    child: Text(
                      "Working Time: $accuracy",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                        child: Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: _stopWatchController,
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 15,
                                  ),
                                  child: Text(
                                    '$buttonText',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // Landscape UI
          else {
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff1542bf), Color(0xff51a8ff)],
                begin: FractionalOffset(0.5, 1),
              )),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment(0.0, 1.0),
                      child: Text(
                        timeToDisplay,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 70.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                        child: Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: _stopWatchController,
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 15,
                                  ),
                                  child: Text(
                                    '$buttonText',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}

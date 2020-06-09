import 'dart:async';
import 'package:breather/domain/entity/task.dart';
import 'package:breather/screens/break_page.dart';
import 'package:breather/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class StudyingPage extends StatefulWidget {
  final Task task;

  StudyingPage({ @required this.task });
  @override
  _StudyingPageState createState() => _StudyingPageState();
}

class _StudyingPageState extends State<StudyingPage> {
  Timer _timer;
  double divisions = 1800;

  double init = 0;
  double position = 0;
  bool isRunning = false;
  TaskStatus status = TaskStatus.initial;

  List<String> plantAnimations = <String>[
    'assets/animations/12830-plant-1.json',
    'assets/animations/12831-plant-2.json',
    'assets/animations/12833-planta-3.json',
    'assets/animations/12834-plant-4.json',
    'assets/animations/4251-plant-office-desk.json',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), _updateTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime(Timer timer) {
    if (status == TaskStatus.running && position < divisions) {
      setState(() {
        position = position + 20;
      });
    } else if (position == divisions) {
      setState(() {
        status = TaskStatus.done;
      });
    }
  }

  String _formatTime(double time) {
    int hours = time ~/ 3600;
    int minutes = (time - hours * 3600) ~/ 60;
    int seconds = time.toInt() % 60;
    final m = _formatExtraZero(minutes);
    final s = _formatExtraZero(seconds);

    return hours > 0 ? '${_formatExtraZero(hours)}:$m:$s' : '$m:$s';
  }

  String _formatExtraZero(int number) {
    return number >= 10 ? '$number' : '0$number';
  }

  void _updateStatus() {
    setState(() {
      switch (status) {
        case TaskStatus.initial:
          status = TaskStatus.running;
          break;
        case TaskStatus.running:
          status = TaskStatus.stopped;
          break;
        case TaskStatus.stopped:
          status = TaskStatus.running;
          break;
        case TaskStatus.done:
          _goToBreakPage();
          break;
        default:
      }
    });
  }

  void _goToBreakPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BreakPage()),
    );
  }

  String _getCtaText() {
    switch (status) {
      case TaskStatus.initial:
        return "Start now";
      case TaskStatus.running:
        return "Pause";
      case TaskStatus.stopped:
        return "Let's continue";
      case TaskStatus.done:
        return "Take a break";
    }

    return "";
  }

  IconData _getCtaIcon() {
    switch (status) {
      case TaskStatus.initial:
        return Icons.play_circle_outline;
      case TaskStatus.running:
        return Icons.pause_circle_outline;
      case TaskStatus.stopped:
        return Icons.play_circle_outline;
      case TaskStatus.done:
        return Icons.free_breakfast;
    }

    return Icons.play_circle_outline;
  }

  @override
  Widget build(BuildContext context) {
    final CircularSliderAppearance appearance01 = CircularSliderAppearance(
        customWidths: CustomSliderWidths(
          trackWidth: 10,
          progressBarWidth: 10,
          shadowWidth: 10,
          handlerSize: 15,
        ),
        customColors: CustomSliderColors(
            dotColor: LightColors.kYellowishOrange,
            trackColor: LightColors.kDarkMint,
            progressBarColor: LightColors.kLavender,
            shadowColor: LightColors.kLavender,
            shadowStep: 10.0,
            shadowMaxOpacity: 1),
        startAngle: 270,
        angleRange: 360,
        size: 300.0,
        animationEnabled: true);
    return Container(
        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0.0028464142233133307, 0.25602471828460693),
                end: Alignment(0.6867927312850952, 0.5929393172264099),
                colors: [LightColors.kGreen, LightColors.kSeaGreen])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.task.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                SizedBox(height: 80),
                SleekCircularSlider(
                    appearance: appearance01,
                    min: init,
                    max: divisions,
                    initialValue: position,
                    innerWidget: (double value) {
                      var index = ((value / divisions) * 4).toInt();
                      return Padding(
                        padding: const EdgeInsets.all(32.0),
                        child:
                            Center(child: Lottie.asset(plantAnimations[index])),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${_formatTime(position)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                  ),
                ),
                // FlatButton(
                //   child: Text(isRunning ? 'Stop' : 'Start'),
                //   textColor: Colors.white,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(50.0),
                //   ),
                //   onPressed: _updateStatus,
                // ),
              ],
            )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: _updateStatus,
              tooltip: (_getCtaText()),
              label: Text(_getCtaText()),
              icon: Icon(_getCtaIcon()),
              backgroundColor: LightColors.kYellowishOrange,
            )));
  }
}

enum TaskStatus { initial, running, done, stopped }

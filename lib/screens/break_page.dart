import 'package:breather/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BreakPage extends StatefulWidget {
  @override
  _BreakPageState createState() => _BreakPageState();
}

class _BreakPageState extends State<BreakPage> {
  final stretchAnimations = [
    'assets/animations/22918-sit-up.json',
    'assets/animations/22922-wall-sitting.json',
    'assets/animations/22923-push-up-with-beard.json',
    'assets/animations/22924-man-with-beard-doing-sit-up.json',
    'assets/animations/22925-abs-crunches.json',
    'assets/animations/22929-triceps-dips.json',
    'assets/animations/23152-high-stepping.json',
    'assets/animations/23157-lunges.json',
    'assets/animations/23158-side-plank.json',
    'assets/animations/23171-chair-stand-excercise.json',
  ];
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(
                "Break Time",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "You have been studying for 1 hour!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Lottie.asset(stretchAnimations[index % 10]),
              InkWell(
                onTap: () {
                  setState(() {
                    index++;
                  });
                },
                child: Container(
                  width: 271.3826904296875,
                  height: 60.638671875,
                  alignment: Alignment(0.0, 0.0),
                  decoration: BoxDecoration(
                    color: Color(0xfff6fbfc),
                    borderRadius: BorderRadius.circular(89.48417663574219),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x4da7aaa9),
                          offset: Offset(7, 7),
                          blurRadius: 20,
                          spreadRadius: 0)
                    ],
                  ),
                  child: // Let’s Stretch
                      Text("Let’s Stretch",
                          style: const TextStyle(
                              color: LightColors.kSeaGreen,
                              fontWeight: FontWeight.w700,
                              fontFamily: "RobotoSlab",
                              fontStyle: FontStyle.normal,
                              fontSize: 23.0),
                          textAlign: TextAlign.center),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 145.796630859375,
                  height: 61.165283203125,
                  alignment: Alignment(0.0, 0.0),
                  decoration: BoxDecoration(
                    color: Color(0xff14ada5),
                    borderRadius: BorderRadius.circular(88.10017395019531),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x4dbcc1bc),
                          offset: Offset(0, 5),
                          blurRadius: 20,
                          spreadRadius: 0)
                    ],
                  ),
                  child: new Text("Snooze",
                      style: TextStyle(
                        fontFamily: 'RobotoSlab',
                        color: Color(0xfff6fbfc),
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
                ),
              )
            ],
          ))),
    );
  }
}

import 'package:breather/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color boxColor;
  final double loadingPercent;

  TaskContainer(
      {this.title, this.subtitle, this.boxColor, this.loadingPercent});

  @override
  Widget build(BuildContext context) {
     double c_width = MediaQuery.of(context).size.width*0.8;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      width: c_width,
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircularPercentIndicator(
            animation: true,
            radius: 75.0,
            percent: loadingPercent,
            lineWidth: 10.0,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: LightColors.kDarkMint.withOpacity(0.3),
            progressColor: LightColors.kDarkMint,
            center: Text(
              '${(loadingPercent * 100).round()}%',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 17.0),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              subtitle,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45),
            ),
          ],
        ))
        
      ]),
      decoration: BoxDecoration(
        color: LightColors.kWhite,
        borderRadius: BorderRadius.circular(138.0),
        boxShadow: [
          BoxShadow(
              color: Color(0x4dbcc1bc),
              offset: Offset(0, 5),
              blurRadius: 20,
              spreadRadius: 0)
        ],
      ),
    );
  }
}

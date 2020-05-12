import 'package:flutter/material.dart';
import 'package:breather/theme/colors/light_colors.dart';
import 'package:breather/widgets/top_container.dart';
import 'package:breather/widgets/back_button.dart';
import 'package:breather/widgets/my_text_field.dart';

class CreateNewTaskPage extends StatelessWidget {
  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 60, 20, 40),
              width: width,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Create new task',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
                            color: LightColors.kWhite),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyTextField(label: 'Name'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: MyTextField(
                              label: 'Due Date',
                              icon: downwardIcon,
                            ),
                          ),
                          calendarIcon(),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: MyTextField(
                        label: 'Progress Time',
                        icon: downwardIcon,
                      )),
                      // SizedBox(width: 40),
                      // Expanded(
                      //   child: MyTextField(
                      //     label: 'End Time',
                      //     icon: downwardIcon,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    label: 'Notes',
                    minLines: 3,
                    maxLines: 3,
                  ),
                  SizedBox(height: 20),
                  // Container(
                  //   alignment: Alignment.topLeft,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       Text(
                  //         'Category',
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           color: Colors.black54,
                  //         ),
                  //       ),
                  //       Wrap(
                  //         crossAxisAlignment: WrapCrossAlignment.start,
                  //         //direction: Axis.vertical,
                  //         alignment: WrapAlignment.start,
                  //         verticalDirection: VerticalDirection.down,
                  //         runSpacing: 0,
                  //         //textDirection: TextDirection.rtl,
                  //         spacing: 10.0,
                  //         children: <Widget>[
                  //           Chip(
                  //             label: Text("SPORT APP"),
                  //             backgroundColor: LightColors.kRed,
                  //             labelStyle: TextStyle(color: Colors.white),
                  //           ),
                  //           Chip(
                  //             label: Text("MEDICAL APP"),
                  //           ),
                  //           Chip(
                  //             label: Text("RENT APP"),
                  //           ),
                  //           Chip(
                  //             label: Text("NOTES"),
                  //           ),
                  //           Chip(
                  //             label: Text("GAMING PLATFORM APP"),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, 'show');
              },
              child: Container(
                height: 80,
                width: width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Create Task',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: width - 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            LightColors.kPeach,
                            LightColors.kYellowishOrange
                          ],
                          stops: [0.006, 1],
                          begin: Alignment(-0.94, -0.34),
                          end: Alignment(0.94, 0.34),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x4d8484ce),
                              offset: Offset(7, 0),
                              blurRadius: 15,
                              spreadRadius: 0)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

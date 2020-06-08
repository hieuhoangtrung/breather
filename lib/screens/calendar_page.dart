import 'package:breather/widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:breather/utils/dates_list.dart';
import 'package:breather/theme/colors/light_colors.dart';
import 'package:breather/widgets/calendar_dates.dart';
import 'package:breather/widgets/calendar_task_container.dart';
import 'package:breather/widgets/back_button.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatelessWidget {
  String thisMonth = new DateFormat.yMMM().format(new DateTime.now());
  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style:
            TextStyle(fontSize: 20.0, color: Colors.black12, letterSpacing: 5),
      ),
    );
  }

  //  _navigateAndDisplaySelection(BuildContext context) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => CreateNewTaskPage()),
  //   );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kPaleGray,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: <Widget>[
            TopContainer(
                child: Column(children: <Widget>[
              SizedBox(height: 40.0),
              MyBackButton(),
              SizedBox(height: 30.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Today',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                          color: LightColors.kWhite),
                    ),
                    // Container(
                    //   height: 40.0,
                    //   width: 120,
                    //   decoration: BoxDecoration(
                    //     color: LightColors.kGreen,
                    //     borderRadius: BorderRadius.circular(30),
                    //   ),
                    //   child: FlatButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => CreateNewTaskPage(),
                    //         ),
                    //       );
                    //     },
                    //     child: Center(
                    //       child: Text(
                    //         'Add task',
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.w700,
                    //             fontSize: 16),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ]),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Productive Day, Peter',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: LightColors.kWhite,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
            ])),
            SizedBox(height: 30),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        thisMonth,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 58.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: daylist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CalendarDates(
                            day: weekdays[daylist[index].weekday - 1],
                            date: daylist[index].day.toString(),
                            dayColor:
                                index == 0 ? LightColors.kRed : Colors.black54,
                            dateColor: index == 0
                                ? LightColors.kRed
                                : LightColors.kDarkBlue,
                          );
                        },
                      ),
                    ),
                  ],
                  
                )),
                Expanded(child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        // padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: ListView.builder(
                                itemCount: time.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${time[index]} ${time[index] > 8 ? 'PM' : 'AM'}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 5,
                              child: ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  _dashedText(),
                                  TaskContainer(
                                    title: 'Create Presentation for Weekly Progress',
                                    subtitle:
                                        'Discuss with the team about the plan',
                                    boxColor: LightColors.kLightYellow2,
                                  ),
                                  _dashedText(),
                                  TaskContainer(
                                    title: 'Work on Mid-fi Prototype',
                                    subtitle: 'Coordinate with Nikita',
                                    boxColor: LightColors.kLavender,
                                  ),
                                  TaskContainer(
                                    title: 'Write down lecture notes and review',
                                    subtitle: 'Watch video again',
                                    boxColor: LightColors.kPalePink,
                                  ),
                                  TaskContainer(
                                    title: 'Assignment 2 Physical Prototyping',
                                    subtitle:
                                        'Coding coding and coding',
                                    boxColor: LightColors.kLightGreen,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),),
          ],
        ),
      ),
    );
  }
}

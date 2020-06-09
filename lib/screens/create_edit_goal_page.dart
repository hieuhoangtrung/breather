import 'dart:math';

import 'package:breather/domain/entity/goal.dart';
import 'package:breather/domain/entity/task.dart';
import 'package:breather/stores/goal_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:breather/theme/colors/light_colors.dart';
import 'package:breather/widgets/top_container.dart';
import 'package:breather/widgets/back_button.dart';
import 'package:breather/widgets/my_text_field.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateNewTaskPage extends StatefulWidget {
  final Goal goal;

  CreateNewTaskPage({this.goal});
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
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  String name;
  DateTime dueDate;
  GoalStore _goalStore;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      name = widget.goal?.name ?? "";
      dueDate = widget.goal?.dueDate;
      isEditing = widget.goal != null;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _goalStore ??= Provider.of<GoalStore>(context);
    // _goalStore.loadGoals();
    // handle disposer if needed
  }

  void _setDueDate() async {
    CupertinoRoundedDatePicker.show(
      context,
      fontFamily: "Mali",
      textColor: Colors.white,
      background: Colors.red[300],
      borderRadius: 16,
      minimumDate: DateTime.now().subtract(Duration(minutes: 1)),
      maximumDate: DateTime.now().add(Duration(days: 60)),
      // minuteInterval: 5,
      initialDatePickerMode: CupertinoDatePickerMode.dateAndTime,
      onDateTimeChanged: (newDateTime) {
        setState(() {
          dueDate = newDateTime;
        });
      },
    );
  }

  void _createNewGoal() {
    if (isEditing) {
      Goal updatedGoal = Goal(
          name: name,
          dueDate: dueDate,
          id: widget.goal.id,
          color: widget.goal.color);
      _goalStore.updateGoal(updatedGoal);
    } else {
      var rng = new Random();
      Goal goal =
          Goal(name: name, dueDate: dueDate, color: rng.nextInt(100) % 18);
      _goalStore.addGoal(goal);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      backgroundColor: LightColors.kPaleGray,
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 60, 20, 40),
              width: width,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      MyBackButton(),
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.goal == null
                                ? 'Create new goal'
                                : 'Edit this goal',
                            style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.w700,
                                color: LightColors.kWhite),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyTextField(
                        label: 'Write down your goal',
                        initialValue: name,
                        onChanged: (text) {
                          setState(() => name = text);
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: _setDueDate,
                              child: Text(
                                dueDate == null
                                    ? 'Set Due Date'
                                    : 'Due date: ${DateFormat('yyyy-MM-dd – kk:mm').format(dueDate)}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                          FlatButton(
                              onPressed: _setDueDate,
                              child: CreateNewTaskPage.calendarIcon()),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Text(
            //   'Break down your goal into smaller tasks',
            //   style: TextStyle(
            //       color: Colors.black45,
            //       fontWeight: FontWeight.w600,
            //       fontSize: 16.0),
            // ),
            // Expanded(
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 10.0),
            //     child: ListView.builder(
            //       itemBuilder: (BuildContext context, int index) {
            //         if (index == _todos.length) {
            //           return SizedBox(
            //             height: 56, // size of FAB
            //           );
            //         }
            //         var todo = _todos[index];
            //         return Container(
            //           child: ListTile(
            //             onTap: () => print('Update todo'),
            //             contentPadding:
            //                 EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
            //             leading: Checkbox(
            //                 onChanged: (value) => print('value: $value'),
            //                 value: true),
            //             trailing: IconButton(
            //               icon: Icon(Icons.delete_outline),
            //               onPressed: () => print('On pressed delete'),
            //             ),
            //             title: Text(
            //               todo.name,
            //               style: TextStyle(
            //                 fontSize: 18.0,
            //                 fontWeight: FontWeight.w600,
            //                 color: true ? LightColors.kGreen : Colors.black54,
            //                 decoration: true
            //                     ? TextDecoration.lineThrough
            //                     : TextDecoration.none,
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //       itemCount: _todos.length + 1,
            //     ),
            //   ),
            // ),
            SizedBox(height: 40),
            // Expanded(
            //     child: SingleChildScrollView(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: Column(
            //     children: <Widget>[
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Text(
            //         'Break down your goal into smaller tasks',
            //         style: TextStyle(
            //             color: Colors.black45,
            //             fontWeight: FontWeight.w600,
            //             fontSize: 16.0),
            //       ),

            //       // Row(
            //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       //   children: <Widget>[
            //       //     Expanded(
            //       //         child: MyTextField(
            //       //       label: 'Progress Time',
            //       //       icon: downwardIcon,
            //       //     )),
            //       //     // SizedBox(width: 40),
            //       //     // Expanded(
            //       //     //   child: MyTextField(
            //       //     //     label: 'End Time',
            //       //     //     icon: downwardIcon,
            //       //     //   ),
            //       //     // ),
            //       //   ],
            //       // ),
            //       // SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MyTextField(
                      label: 'Notes',
                      minLines: 3,
                      maxLines: 3,
                    ),
                  ),
            //       // SizedBox(height: 20),
            //       // Container(
            //       //   alignment: Alignment.topLeft,
            //       //   child: Column(
            //       //     crossAxisAlignment: CrossAxisAlignment.start,
            //       //     children: <Widget>[
            //       //       Text(
            //       //         'Category',
            //       //         style: TextStyle(
            //       //           fontSize: 18,
            //       //           color: Colors.black54,
            //       //         ),
            //       //       ),
            //       //       Wrap(
            //       //         crossAxisAlignment: WrapCrossAlignment.start,
            //       //         //direction: Axis.vertical,
            //       //         alignment: WrapAlignment.start,
            //       //         verticalDirection: VerticalDirection.down,
            //       //         runSpacing: 0,
            //       //         //textDirection: TextDirection.rtl,
            //       //         spacing: 10.0,
            //       //         children: <Widget>[
            //       //           Chip(
            //       //             label: Text("SPORT APP"),
            //       //             backgroundColor: LightColors.kRed,
            //       //             labelStyle: TextStyle(color: Colors.white),
            //       //           ),
            //       //           Chip(
            //       //             label: Text("MEDICAL APP"),
            //       //           ),
            //       //           Chip(
            //       //             label: Text("RENT APP"),
            //       //           ),
            //       //           Chip(
            //       //             label: Text("NOTES"),
            //       //           ),
            //       //           Chip(
            //       //             label: Text("GAMING PLATFORM APP"),
            //       //           ),
            //       //         ],
            //       //       ),
            //       //     ],
            //       //   ),
            //       // )
            //     ],
            //   ),
            // )),
            // FlatButton(
            //   onPressed: name != ""
            //       ? _createNewGoal
            //       : null,
            //   child: Container(
            //     height: 60,
            //     width: width,
            //     margin: EdgeInsets.symmetric(vertical: 20.0),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.stretch,
            //       children: <Widget>[
            //         Container(
            //           child: Text(
            //             'Create Goal',
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w700,
            //                 fontSize: 18),
            //           ),
            //           alignment: Alignment.center,
            //           width: width - 40,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(30),
            //             gradient: LinearGradient(
            //               colors: [
            //                 LightColors.kPeach,
            //                 LightColors.kYellowishOrange
            //               ],
            //               stops: [0.006, 1],
            //               begin: Alignment(-0.94, -0.34),
            //               end: Alignment(0.94, 0.34),
            //             ),
            //             boxShadow: [
            //               BoxShadow(
            //                   color: Color(0x4d8484ce),
            //                   offset: Offset(7, 0),
            //                   blurRadius: 15,
            //                   spreadRadius: 0)
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: name.isEmpty
            ? () {
                final snackBar = SnackBar(
                  content: Text(
                    'Ummm... It seems that you are trying to add an invisible goal which is not allowed in this realm.',
                    style: TextStyle(color: LightColors.kDark),
                  ),
                  backgroundColor: LightColors.kWhite,
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
            : _createNewGoal,
        tooltip: !isEditing ? 'Create new goal' : 'Update your changes',
        label: Text(!isEditing ? 'Create new goal' : 'Update your changes'),
        icon: Icon(isEditing ? Icons.system_update_alt : Icons.create),
        backgroundColor: LightColors.kYellowishOrange,
      ),
    );
  }
}

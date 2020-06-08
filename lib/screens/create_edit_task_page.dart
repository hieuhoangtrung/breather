import 'package:breather/domain/entity/goal.dart';
import 'package:breather/domain/entity/task.dart';
import 'package:breather/screens/create_edit_goal_page.dart';
import 'package:breather/stores/goal_store.dart';
import 'package:breather/theme/colors/light_colors.dart';
import 'package:breather/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:provider/provider.dart';

class CreateEditTaskPage extends StatefulWidget {
  final Goal goal;
  final Task task;

  CreateEditTaskPage({@required this.goal, this.task});

  @override
  _CreateEditTaskPageState createState() => _CreateEditTaskPageState();
}

class _CreateEditTaskPageState extends State<CreateEditTaskPage> {
  String name;
  Duration duration;
  int priority = 0;
  GoalStore _goalStore;

  void _setDueDate() async {
    CupertinoRoundedDurationPicker.show(
      context,
      textColor: Colors.white,
      background: Colors.red[300],
      initialTimerDuration: Duration(minutes: 30),
      minuteInterval: 5,
      initialDurationPickerMode: CupertinoTimerPickerMode.hm,
      fontFamily: "Mali",
      onDurationChanged: (newDuration) {
        setState(() {
          duration = newDuration;
        });
      },
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}h ${twoDigitMinutes}m";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _goalStore ??= Provider.of<GoalStore>(context);
    // _goalStore.loadGoals();
    // handle disposer if needed
  }

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
        body: Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  MyBackButton(),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.task == null ? 'Add new task' : 'Edit your task',
                        style: TextStyle(
                            fontSize: 30.0,
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
              Text(
                'What task are you planning to perfrom?',
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0),
              ),
              Container(
                height: 16.0,
              ),
              TextField(
                onChanged: (text) {
                  setState(() => name = text);
                },
                // cursorColor: widget.goal.color,
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your Task...',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    )),
                style: TextStyle(
                    color: LightColors.kWhite,
                    fontWeight: FontWeight.w500,
                    fontSize: 36.0),
              ),
              Container(
                height: 26.0,
              ),
              Container(
                child: Row(
                  children: [
                    Hero(
                      child: Text(
                        'for \n${widget.goal.name}',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.visible,
                        maxLines: 3,
                      ),
                      tag: "not_using_right_now", //widget.heroIds.titleId,
                    ),
                  ],
                ),
              ),
              Container(
                height: 26.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: _setDueDate,
                      child: Text(
                        duration == null
                            ? 'Set Progress Time'
                            : 'Progress Time: ${_printDuration(duration)}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                  FlatButton(
                      onPressed: _setDueDate,
                      child: CreateNewTaskPage.calendarIcon()),
                ],
              ),
              Container(
                height: 26.0,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Priority',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    Container(
                      height: 8.0,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceEvenly,
                      // verticalDirection: VerticalDirection.down,
                      runSpacing: 0,
                      //textDirection: TextDirection.rtl,
                      spacing: 10.0,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              priority = 0;
                            });
                          },
                          child: Chip(
                            label: Text("Low"),
                            backgroundColor: priority == 0
                                ? LightColors.kRed
                                : LightColors.kWhite,
                            labelStyle: TextStyle(
                                color: priority == 0
                                    ? LightColors.kWhite
                                    : LightColors.kDark),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              priority = 1;
                            });
                          },
                          child: Chip(
                            label: Text("Medium"),
                            backgroundColor: priority == 1
                                ? LightColors.kRed
                                : LightColors.kWhite,
                            labelStyle: TextStyle(
                                color: priority == 1
                                    ? LightColors.kWhite
                                    : LightColors.kDark),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              priority = 2;
                            });
                          },
                          child: Chip(
                            label: Text("High"),
                            backgroundColor: priority == 2
                                ? LightColors.kRed
                                : LightColors.kWhite,
                            labelStyle: TextStyle(
                                color: priority == 2
                                    ? LightColors.kWhite
                                    : LightColors.kDark),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton.extended(
              heroTag: 'fab_new_task',
              icon: Icon(Icons.add),
              backgroundColor: LightColors.kYellowishOrange,
              label: Text('Create Task'),
              onPressed: () {
                if (name.isEmpty) {
                  final snackBar = SnackBar(
                    content: Text(
                      'Ummm... It seems that you are trying to add an invisible task which is not allowed in this realm.',
                      style: TextStyle(color: LightColors.kDark),
                    ),
                    backgroundColor: LightColors.kWhite,
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                  // _scaffoldKey.currentState.showSnackBar(snackBar);
                } else {
                  var task = Task(
                      name: name,
                      goalId: widget.goal.id,
                      duration: duration.inSeconds ?? 1800,
                      isCompleted: 0,
                      priority: priority);
                  _goalStore.createTask(task);
                  Navigator.pop(context);
                }
              },
            );
          },
        ),
      ),
    );
  }
}

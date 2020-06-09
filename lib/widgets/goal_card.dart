import 'package:breather/domain/entity/goal.dart';
import 'package:breather/domain/entity/task.dart';
import 'package:breather/screens/create_edit_goal_page.dart';
import 'package:breather/screens/create_edit_task_page.dart';
import 'package:breather/stores/goal_store.dart';
import 'package:breather/theme/colors/light_colors.dart';
import 'package:breather/utils/color_utils.dart';
import 'package:breather/widgets/alert_dialog.dart';
import 'package:breather/widgets/task_progress_indicator.dart';
import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  final GlobalKey backdropKey;
  final Goal goal;
  final Color color;
  final GoalStore goalStore;

  GoalCard({this.backdropKey, this.goal, this.color, this.goalStore});

  // @override
  // void initState() {
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
        future: goalStore.getTasksByGoalId(goal.id),
        builder: (context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasData) {
            var tasks = snapshot.data;
            var sum = 0;
            tasks.forEach((element) { sum = sum + element.isCompleted; });

            var progress = tasks.length == 0 ? 0 : sum / tasks.length * 100;
            return InkWell(
                onTap: () {
                  print('Goal Card. Open Card detail here');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  color: Colors.white,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: LightColors.kGreen,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateNewTaskPage(
                                      goal: goal,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SimpleAlertDialog(
                                color: LightColors.kRed,
                                onActionPressed: () {
                                  goalStore.deleteGoal(goal);
                                  goalStore.loadGoals();
                                }),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Hero(
                            tag: 'goal_title_${goal.id}',
                            child: Text(goal.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(color: color)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4.0),
                          child: Hero(
                            tag: 'goal_id_${goal.id}',
                            child: Text(
                              "${tasks.length} task",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.grey[500]),
                            ),
                          ),
                        ),
                        Hero(
                            tag: 'progress_indicator_${goal.id}',
                            child: TaskProgressIndicator(
                                color: ColorUtils.getColorFrom(id: goal.color),
                                progress: progress.round())),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 10.0),
                            itemBuilder: (BuildContext context, int index) {
                              if (index == tasks.length) {
                                return SizedBox(
                                  height: 56, // size of FAB
                                );
                              }
                              var todo = tasks[index];
                              return Container(
                                child: ListTile(
                                  onTap: () {
                                    print('Select task');
                                  },
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0.0),
                                  leading: Checkbox(
                                      onChanged: (value) {
                                        var task = tasks[index];
                                        var isCompleted =
                                            task.isCompleted == 1 ? 0 : 1;
                                        var updatedTask = task.copy(
                                            isCompleted: isCompleted);
                                        goalStore.updateTask(updatedTask);

                                        print('value: $value');
                                      },
                                      value: tasks[index].isCompleted == 1),
                                  // trailing: IconButton(
                                  //   icon: Icon(Icons.delete_outline),
                                  //   onPressed: () =>
                                  //       print('On pressed delete'),
                                  // ),
                                  title: Text(
                                    todo.name,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: tasks[index].isCompleted == 1
                                          ? LightColors.kGreen
                                          : Colors.black54,
                                      decoration:
                                          tasks[index].isCompleted == 1
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: tasks.length + 1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: 'add_task_button_${goal.id}',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateEditTaskPage(
                                            goal: goal,
                                          )),
                                );
                              },
                              child: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

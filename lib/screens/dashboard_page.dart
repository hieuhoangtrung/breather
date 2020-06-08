import 'package:breather/domain/entity/user_profile.dart';
import 'package:breather/screens/calendar_page.dart';
import 'package:breather/screens/studying_page.dart';
import 'package:breather/stores/goal_store.dart';
import 'package:breather/theme/colors/light_colors.dart';
import 'package:breather/widgets/task_container.dart';
import 'package:breather/widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:breather/domain/entity/task.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GoalStore _goalStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _goalStore ??= Provider.of<GoalStore>(context);
    _goalStore.loadGoals();
    // handle disposer if needed
  }

  void _startStudying() {
    print('Start Studying now!');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudyingPage(task: tasks[0])),
    );
  }

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDark,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  List<Task> tasks = <Task>[
    Task(
        id: 1,
        name: "Create Presentation for Weekly Progress",
        note: "30 minutes progress",
        loadingPercent: 0.25),
    Task(
        id: 2,
        name: "Work on Mid-fi Prototype",
        note: "1 hour progress",
        loadingPercent: 0.5),
    Task(
        id: 3,
        name: "Write down lecture notes and review",
        note: "1 hour progress",
        loadingPercent: 0.3),
    Task(
        id: 4,
        name: "Assignment 2 Physical Prototyping",
        note: "30 minutes progress",
        loadingPercent: 0.7),
    Task(
        id: 5,
        name: "Create Presentation for Weekly Progress",
        note: "30 minutes progress",
        loadingPercent: 0.4),
    Task(
        id: 6,
        name: "Create Presentation for Weekly Progress",
        note: "30 minutes progress",
        loadingPercent: 0.7),
  ];

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
        radius: 25.0,
        backgroundColor: Color(0xff31d8bb),
        child: Image.asset('assets/images/calendar_icon@3x.png',
            width: 25, height: 25));
  }

  UserProfile user = UserProfile(
      id: 1,
      fullName: 'Peter',
      profileImageUrl: 'assets/images/avatar.png',
      job: 'Student');

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String welcomeText = "Hi 👋 " + user.fullName + "!";

    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TopContainer(
              height: 250,
              width: width,
              padding:
                  EdgeInsets.only(top: 40.0, left: 20, right: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.menu, color: LightColors.kWhite, size: 30.0),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CalendarPage()),
                          );
                        },
                        child: calendarIcon(),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                welcomeText,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 26.0,
                                    color: LightColors.kWhite,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            if (user.job != null)
                              Container(
                                child: Text(
                                  user.job,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: LightColors.kWhite,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                          ],
                        ),
                        CircularPercentIndicator(
                            animationDuration: 1000,
                            radius: 90.0,
                            lineWidth: 5.0,
                            animation: true,
                            percent: 0.60,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: LightColors.kYellowishOrange,
                            backgroundColor: LightColors.kSeaGreen,
                            center: CircleAvatar(
                              backgroundColor: LightColors.kBlue,
                              radius: 35.0,
                              backgroundImage: AssetImage(user.profileImageUrl),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[subheading("Today's Tasks")],
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskContainer(
                        title: tasks[index].name,
                        subtitle: tasks[index].note,
                        loadingPercent: tasks[index].loadingPercent,
                      );
                    })),
            // Lottie.network(
            //     'https://assets3.lottiefiles.com/packages/lf20_o6hQ8m.json'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startStudying,
        tooltip: 'Start Studying',
        label: Text("Start Studying"),
        icon: Icon(Icons.play_circle_outline),
        backgroundColor: LightColors.kYellowishOrange,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

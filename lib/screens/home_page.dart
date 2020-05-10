import 'package:breather/domain/entity/task.dart';
import 'package:breather/domain/entity/user_profile.dart';
import 'package:breather/widgets/task_container.dart';
import 'package:breather/widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:breather/theme/colors/light_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  UserProfile user = UserProfile(
    id: 1,
    fullName: 'Peter Hoang',
    profileImageUrl: 'assets/images/avatar.png',
  );

  List<Task> tasks = <Task>[
    Task(
        id: 1,
        title: "Create Presentation for Weekly Progress",
        subtitle: "30 minutes progress",
        loadingPercent: 0.2),
    Task(
        id: 2,
        title: "Create Presentation for Weekly Progress",
        subtitle: "30 minutes progress",
        loadingPercent: 0.5),
    Task(
        id: 3,
        title: "Create Presentation for Weekly Progress",
        subtitle: "30 minutes progress",
        loadingPercent: 0.3),
    Task(
        id: 4,
        title: "Create Presentation for Weekly Progress",
        subtitle: "30 minutes progress",
        loadingPercent: 0.7),
    Task(
        id: 5,
        title: "Create Presentation for Weekly Progress",
        subtitle: "30 minutes progress",
        loadingPercent: 0.4),
    Task(
        id: 6,
        title: "Create Presentation for Weekly Progress",
        subtitle: "30 minutes progress",
        loadingPercent: 0.7),
  ];

  void _incrementCounter() {
    setState(() {
      // _counter++;
      tasks.add(Task(
          id: 1,
          title: "New Tasks",
          subtitle: "30 minutes progress",
          loadingPercent: 0));
    });
    debugPrint(user.profileImageUrl);
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

  // static CircleAvatar calendarIcon() {
  //   return CircleAvatar(
  //     radius: 25.0,
  //     decoration: new BoxDecoration(
  //         color: Color(0xff31d8bb),
  // 	boxShadow: [BoxShadow(
  //       color: Color(0x4dd6d8d4),
  //       offset: Offset(7,7),
  //       blurRadius: 20,
  //       spreadRadius: 0

  //   ),
  //     child: Icon(
  //       Icons.calendar_today,
  //       size: 20.0,
  //       color: Colors.white,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String welcomeText = "Hi 👋 \n" + user.fullName + "!";

    return Scaffold(
      backgroundColor: LightColors.kPaleGray,
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TopContainer(
              height: 200,
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
                      Icon(Icons.calendar_today,
                          color: LightColors.kWhite, size: 25.0)
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: LightColors.kBlue,
                          radius: 35.0,
                          backgroundImage: AssetImage(user.profileImageUrl),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                welcomeText,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 26.0,
                                    color: Color(0xffffffff),
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
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                          ],
                        )
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
                  SizedBox(height: 15.0),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskContainer(
                        title: tasks[index].title,
                        subtitle: tasks[index].subtitle,
                        loadingPercent: tasks[index].loadingPercent,
                      );
                    })),
            // Lottie.network(
            //     'https://assets3.lottiefiles.com/packages/lf20_o6hQ8m.json'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        tooltip: 'Add new Task',
        label: Text("Start"),
        icon: Icon(Icons.play_circle_outline),
        backgroundColor: Color(0xfffbae17),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

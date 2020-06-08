import 'package:breather/screens/dashboard_page.dart';
import 'package:breather/screens/goal_list_page.dart';
import 'package:breather/screens/plant_garden_page.dart';
import 'package:flutter/material.dart';
import 'package:breather/theme/colors/light_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:breather/screens/calendar_page.dart';
import 'package:rolling_nav_bar/rolling_nav_bar.dart';
import 'package:rolling_nav_bar/indexed.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _incrementCounter() {
    // setState(() {
    //   tasks.add(Task(
    //       id: 1,
    //       name: "New Tasks",
    //       note: "30 minutes progress",
    //       loadingPercent: 0));
    // });
    // debugPrint(user.profileImageUrl);
    // var goal = Goal(name: 'Goal ${_goalStore.goals.length + 1}');
    // _goalStore.addGoal(goal);
  }

  final List<Widget> _children = [
    DashboardPage(),
    GoalListPage(),
    PlantGardenPage(),
    CalendarPage(),
  ];

  // nav bar
  Color logoColor;
  int activeIndex;

  var iconData = <IconData>[
    Icons.home,
    Icons.assignment,
    Icons.local_florist,
    Icons.calendar_today
  ];

  var badges = <int>[null, null, null, 1];

  var iconText = <Widget>[
    Text('Home', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Goals', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Gifts', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Calendar', style: TextStyle(color: Colors.grey, fontSize: 12)),
  ];

  var indicatorColors = <Color>[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  List<Widget> get badgeWidgets => indexed(badges)
      .map((Indexed indexed) => indexed.value != null
          ? Text(indexed.value.toString(),
              style: TextStyle(
                color: indexed.index == activeIndex
                    ? indicatorColors[indexed.index]
                    : Colors.white,
              ))
          : null)
      .toList();

  @override
  void initState() {
    logoColor = Colors.red[600];
    activeIndex = 0;
    super.initState();
  }

  void incrementIndex() {
    setState(() {
      activeIndex = activeIndex < (iconData.length - 1) ? activeIndex + 1 : 0;
      print(activeIndex);
    });
  }

  // ignore: unused_element
  _onAnimate(AnimationUpdate update) {
    setState(() {
      logoColor = update.color;
    });
  }

  _onTap(int index) {
    activeIndex = index;
    print(activeIndex);
  }

  double scaledHeight(BuildContext context, double baseSize) {
    return baseSize * (MediaQuery.of(context).size.height / 800);
  }

  double scaledWidth(BuildContext context, double baseSize) {
    return baseSize * (MediaQuery.of(context).size.width / 375);
  }

  @override
  Widget build(BuildContext context) {
    double navBarHeight = scaledHeight(context, 85);

    return Scaffold(
      bottomNavigationBar: Container(
          // bottom: 0,
          height: navBarHeight,
          width: MediaQuery.of(context).size.width,
          // Option 1: Recommended
          child: RollingNavBar.iconData(
            activeBadgeColors: <Color>[
              Colors.white,
            ],
            activeIndex: activeIndex,
            animationCurve: Curves.linear,
            animationType: AnimationType.shrinkOutIn,
            baseAnimationSpeed: 200,
            badges: badgeWidgets,
            iconData: iconData,
            iconColors: <Color>[Colors.grey[800]],
            iconText: iconText,
            indicatorColors: indicatorColors,
            iconSize: 25,
            indicatorRadius: scaledHeight(context, 30),
            onAnimate: _onAnimate,
            onTap: _onTap,
          )),
      backgroundColor: LightColors.kPaleGray,
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: _children[activeIndex]
    );
  }
}

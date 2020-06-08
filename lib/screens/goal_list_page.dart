import 'package:breather/stores/goal_store.dart';
import 'package:breather/theme/colors/light_colors.dart';
import 'package:breather/utils/color_utils.dart';
import 'package:breather/widgets/add_new_goal_card.dart';
import 'package:breather/widgets/goal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class GoalListPage extends StatefulWidget {
  @override
  _GoalListPageState createState() => _GoalListPageState();
}

class _GoalListPageState extends State<GoalListPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  GoalStore _goalStore;
  // List<Goal> _goals;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _goalStore ??= Provider.of<GoalStore>(context);
    _goalStore.loadGoals();
    print("number of goal: ${_goalStore.goals.length}");
    // handle disposer if needed
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0.0028464142233133307, 0.25602471828460693),
              end: Alignment(0.6867927312850952, 0.5929393172264099),
              colors: [LightColors.kGreen, LightColors.kSeaGreen])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Observer(
              builder: (_) => _goalStore.state == StoreState.loading
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5.0,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : FadeTransition(
                      opacity: _animation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Expanded(
                            key: _backdropKey,
                            flex: 1,
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification is ScrollEndNotification) {
                                  print(
                                      "ScrollNotification = ${_pageController.page}");
                                  var currentPage =
                                      _pageController.page.round().toInt();
                                  if (_currentPageIndex != currentPage) {
                                    setState(
                                        () => _currentPageIndex = currentPage);
                                  }
                                }
                              },
                              child: Observer(builder: (_) {
                                return PageView.builder(
                                  controller: _pageController,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == _goalStore.goals.length) {
                                      return AddNewGoalCard(
                                        color: Colors.blueGrey,
                                      );
                                    } else {
                                      return GoalCard(
                                        backdropKey: _backdropKey,
                                        color: ColorUtils.getColorFrom(
                                            id: _goalStore.goals[index].color),
                                        goal: _goalStore.goals[index],
                                        goalStore: _goalStore,
                                      );
                                    }
                                  },
                                  itemCount: _goalStore.goals.length + 1,
                                );
                              }),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 32.0),
                          ),
                        ],
                      ),
                    ))),
    );
  }
}

import 'package:breather/repository/goal_repository.dart';
import 'package:provider/provider.dart';
import 'package:breather/stores/goal_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:breather/theme/colors/light_colors.dart';
import 'package:breather/screens/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(BreatherApp());
}

// use DotEnv: DotEnv().env['VAR_NAME'];

class BreatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => GoalStore(GoalRepository()),
        child: MaterialApp(
          title: 'Breather',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: LightColors.kDarkBlue,
                  displayColor: LightColors.kDarkBlue,
                  fontFamily: 'RobotoSlab')),
          home: HomePage(title: 'Breather'),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: Locale('en', 'US'),
          supportedLocales: [
            const Locale('en', 'US'), // English
          ],
        ));
  }
}

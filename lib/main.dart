import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:breather/theme/colors/light_colors.dart';
import 'package:breather/screens/home_page.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
} 

// use DotEnv: DotEnv().env['VAR_NAME'];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: LightColors.kDarkBlue,
          displayColor: LightColors.kDarkBlue,
          fontFamily: 'RobotoSlab'
        )
      ),
      home: MyHomePage(title: 'Breather'),
      debugShowCheckedModeBanner: false,
    );
  }
}


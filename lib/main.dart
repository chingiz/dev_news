import 'package:dev_news/core/news_provider.dart';
import 'package:dev_news/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NewsProvider())
        ],
        child: LoadingProvider(child: MyApp()),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
      builder: (ThemeMode themeMode) {
        return MaterialApp(
          title: 'DevNews',
          themeMode: themeMode,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
      defaultTheme: ThemeMode.light,
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      backgroundColor: Colors.white,
      primaryIconTheme: IconThemeData(color: Colors.black),
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          body1: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      textTheme: TextTheme(
        display1: TextStyle(
          fontSize: 18,
          color: Colors.black87,
          fontWeight: FontWeight.w700,
        ),
        display2: TextStyle(
          fontSize: 16,
          color: Colors.blueGrey.shade500,
          fontWeight: FontWeight.w400,
        ),
      ),
      brightness: Brightness.light,
    );
  }

  ThemeData darkTheme() {
    //darkTheme colorPalette https://colorhunt.co/palette/179373
    const background = Color(0xFF222831);
    const color1 = Color(0xFF30475e);
    const color2 = Color(0xFFf2a365);
    const color3 = Color(0xFFececec);
    //darkTheme
    return ThemeData(
      backgroundColor: background,
      primaryIconTheme: IconThemeData(color: Colors.white),
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          body1: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      textTheme: TextTheme(
        display1: TextStyle(
          fontSize: 18,
          color: color3,
          fontWeight: FontWeight.w700,
        ),
        display2: TextStyle(
          fontSize: 16,
          color: Colors.blueGrey.shade500,
          fontWeight: FontWeight.w400,
        ),
      ),
      brightness: Brightness.dark,
    );
  }
}

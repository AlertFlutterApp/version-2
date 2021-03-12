import 'package:flutter/material.dart';
import 'package:final_app/bloc/bloc_provider.dart';
import 'package:final_app/pages/home/home.dart';
import 'package:final_app/pages/home/home_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'ThemeDemo.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        locale: Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Colors.lightBlueAccent, primaryColor: Colors.lightBlue//const Color(0xFFDE4435)
        ),
        darkTheme : ThemeData.dark(),
        home:
        BlocProvider(
          bloc: HomeBloc(),
          child: HomePage(),
        )
    );
  }
}
//
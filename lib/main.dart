import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.brown[400],
      statusBarColor: Colors.transparent,
    ));
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Brew Crew',
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

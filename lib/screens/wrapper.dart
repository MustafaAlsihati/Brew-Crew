import 'package:brew_crew/models/user.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/auth/auth.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    // Return home or login/register page.
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

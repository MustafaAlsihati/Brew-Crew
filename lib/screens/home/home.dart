import 'package:brew_crew/icons/settings_icon_icons.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                color: Colors.transparent,
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(15.0),
                      topRight: const Radius.circular(15.0),
                    ),
                  ),
                  child: SettingsForm(),
                ),
              ),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      initialData: List(),
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[400],
        appBar: AppBar(
          title: Text('Brew Crew'),
          centerTitle: true,
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(
                SettingsIcon.cog_outline,
                size: 20,
              ),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}

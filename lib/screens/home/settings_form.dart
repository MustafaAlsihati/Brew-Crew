import 'package:brew_crew/locale/app_localization.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/authservice.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/utils/constants.dart';
import 'package:provider/provider.dart';
import '../wrapper.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String uid;
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    String sugarText = AppLocalizations.of(context).text('sugar');
    final user = Provider.of<User>(context);
    try {
      if (user.uid != null) {
        uid = user.uid;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }

    return Theme(
      data: ThemeData(
        primaryColor: Colors.brown[400],
        primaryColorDark: Colors.brown[400],
        cursorColor: Colors.brown[100],
      ),
      child: StreamBuilder<UserData>(
        stream: DatabaseService(uid: uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 5.0, left: 20.0, right: 20.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context).text('updateSettings'),
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    padding:
                        EdgeInsets.only(bottom: 5.0, left: 20.0, right: 20.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              initialValue: _currentName ?? userData.name,
                              decoration: brewNameTextInputDecoration(
                                  AppLocalizations.of(context)
                                      .text('userNameHint')),
                              style: TextStyle(fontSize: 17.0),
                              validator: (val) => val.isEmpty
                                  ? AppLocalizations.of(context)
                                      .text('validUserNameMsg')
                                  : null,
                              onChanged: (val) =>
                                  setState(() => _currentName = val),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Flexible(
                          child: SizedBox(
                            height: 40,
                            child: DropdownButtonFormField(
                              value: _currentSugars ?? userData.sugars,
                              decoration: textInputDecoration,
                              isDense: true,
                              onChanged: (val) =>
                                  setState(() => _currentSugars = val),
                              items: sugars.map((sugar) {
                                return DropdownMenuItem(
                                  value: sugar,
                                  child: Text('$sugar $sugarText'),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        SizedBox(
                          height: 39,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Colors.brown[400],
                            child: Text(
                              AppLocalizations.of(context).text('updateBtn'),
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await DatabaseService(uid: user.uid)
                                    .updateUserData(
                                  _currentSugars ?? userData.sugars,
                                  _currentName ?? userData.name,
                                  _currentStrength ?? userData.strength,
                                );
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 5.0, left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).text('coffeeStrength'),
                          style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          (_currentStrength ?? userData.strength).toString(),
                          style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Slider(
                      inactiveColor: Colors.grey[_currentStrength ??
                          userData.strength], // Custom Gray Color
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context).text('logout')),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () async {
                      await _auth.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Wrapper()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                LoadingSpinner(),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).text('logout')),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () async {
                    await _auth.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Wrapper()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

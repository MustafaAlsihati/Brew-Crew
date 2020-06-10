import 'package:brew_crew/locale/app_localization.dart';
import 'package:brew_crew/screens/auth/register.dart';
import 'package:brew_crew/services/authservice.dart';
import 'package:brew_crew/utils/dialogs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Instance of AuthService:
  final AuthService _auth = AuthService();

  // Validation of Form:
  final _formKey = GlobalKey<FormState>();

  // GlobalKey:
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  // Fields values:
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.brown[400],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        brightness: Brightness.dark,
        elevation: 0.0,
        centerTitle: true,
        title: Text(AppLocalizations.of(context).text('signInTitle')),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Theme(
            data: ThemeData(
              primaryColor: Colors.brown[400],
              primaryColorDark: Colors.brown[400],
              cursorColor: Colors.brown[200],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (val) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val);
                      if (emailValid == false) {
                        return AppLocalizations.of(context).text('enterEmail');
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.brown),
                        ),
                        hintText:
                            AppLocalizations.of(context).text('emailHint'),
                        helperText: '',
                        labelText:
                            AppLocalizations.of(context).text('emailHint'),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.brown,
                        ),
                        prefixText: '',
                        suffixText: '',
                        suffixStyle: const TextStyle(color: Colors.black)),
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    validator: (val) => val.length < 6
                        ? AppLocalizations.of(context).text('enterPassword')
                        : null,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.brown),
                        ),
                        hintText:
                            AppLocalizations.of(context).text('passwordHint'),
                        helperText: '',
                        labelText:
                            AppLocalizations.of(context).text('passwordHint'),
                        prefixIcon: const Icon(
                          Icons.vpn_key,
                          color: Colors.brown,
                        ),
                        prefixText: '',
                        suffixText: '',
                        suffixStyle: const TextStyle(color: Colors.black)),
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      color: Colors.brown,
                      child: Text(
                        AppLocalizations.of(context).text('signIn'),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          loadingDialog(_scaffold.currentContext);
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                                  email.trim(), password);
                          Navigator.of(_scaffold.currentContext).pop();
                          if (result == null) {
                            errorDialog(
                                context,
                                AppLocalizations.of(context)
                                    .text('loginError'));
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Center(
                    child: new RichText(
                      text: new TextSpan(
                        children: [
                          new TextSpan(
                            text: AppLocalizations.of(context).text('signUp1'),
                            style: new TextStyle(color: Colors.black54),
                          ),
                          new TextSpan(
                            text: AppLocalizations.of(context).text('signUp2'),
                            style: new TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => Register()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

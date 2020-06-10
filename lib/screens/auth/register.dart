import 'package:brew_crew/locale/app_localization.dart';
import 'package:brew_crew/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/utils/dialogs.dart';
import '../wrapper.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Instance of AuthService:
  final AuthService _auth = AuthService();

  // Validation of Form:
  final _formKey = GlobalKey<FormState>();

  // Fields values:
  String email = '';
  String password = '';
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.brown[400],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        brightness: Brightness.dark,
        elevation: 0.0,
        title: Text(AppLocalizations.of(context).text('signUpTitle')),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
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
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (val) => val.length == 0
                        ? AppLocalizations.of(context).text('validUserNameMsg')
                        : null,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.brown),
                        ),
                        hintText:
                            AppLocalizations.of(context).text('userNameHint'),
                        helperText: '',
                        labelText:
                            AppLocalizations.of(context).text('userNameHint'),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.brown,
                        ),
                        prefixText: '',
                        suffixText: '',
                        suffixStyle: const TextStyle(color: Colors.black)),
                    onChanged: (val) {
                      setState(() {
                        username = val;
                      });
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    validator: (val) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val);
                      if (emailValid == false) {
                        return AppLocalizations.of(context)
                            .text('validEmailMsg');
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
                          Icons.email,
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
                        ? AppLocalizations.of(context).text('validPasswordMsg')
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
                        AppLocalizations.of(context).text('register'),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          loadingDialog(context);
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  email.trim(), password, username.trim());
                          if (result == null) {
                            Navigator.pop(context);
                            errorDialog(
                                context,
                                AppLocalizations.of(context)
                                    .text('errorRegister'));
                          } else {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Wrapper()),
                              (Route<dynamic> route) => false,
                            );
                            successDialog(
                                context,
                                AppLocalizations.of(context)
                                    .text('registerSuccess'));
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

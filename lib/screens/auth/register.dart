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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.brown[400],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up in Brew Crew'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
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
                    validator: (val) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val);
                      if (emailValid == false) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.brown),
                        ),
                        hintText: 'Email Address',
                        helperText: '',
                        labelText: 'Email Address',
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
                        ? 'Please enter a password 6+ chars long'
                        : null,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.brown),
                        ),
                        hintText: 'Password',
                        helperText: '',
                        labelText: 'Password',
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
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          loadingDialog(context);
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  email.trim(), password);
                          if (result == null) {
                            Navigator.pop(context);
                            errorDialog(context,
                                'Error occured, user may already exists');
                          } else {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Wrapper()),
                              (Route<dynamic> route) => false,
                            );
                            successDialog(context, 'Registered Successfully');
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

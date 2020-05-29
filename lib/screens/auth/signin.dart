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
  GlobalKey _scaffold = GlobalKey();

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
        title: Text('Sign In to Brew Crew'),
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
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (val) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val);
                      if (emailValid == false) {
                        return 'Please enter your email address';
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
                    validator: (val) =>
                        val.length < 6 ? 'Please enter your password' : null,
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
                        'Sign In',
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
                                context, 'Incorrect email address or password');
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
                            text: "Don't have an account? ",
                            style: new TextStyle(color: Colors.black54),
                          ),
                          new TextSpan(
                            text: 'Sign up',
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

import 'package:flutter/material.dart';
import 'package:group7/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'chatscreen.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final username = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onSaved: (input) => _email = input,
      decoration: InputDecoration(
        hintText: ' Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final pswd = TextFormField(
      autofocus: false,
      onSaved: (input) => _password = input,
      // initialValue: '..........',
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        onPressed: signIn,
        padding: EdgeInsets.all(12),
        color: Colors.lightBlue,
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    final forgetLabel = FlatButton(
      child: Text(
        'Forgot Password',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );
    var form = Form(
      key: _formKey,
      child:Column(
          children: <Widget>[
            username,
            SizedBox(height: 8.0),
            pswd
          ],
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            form,
            //username,
            //SizedBox(height: 8.0),
            //pswd,
            SizedBox(height: 24.0),
            loginButton,
            forgetLabel
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatScreen()));
      } catch (e) {
        print(e);
      }
    }
  }
}

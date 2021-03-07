import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/Db/Services/AuthService.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final phone_numer = TextEditingController();
  final password_controller = TextEditingController();
  final mail_controller = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void showError() {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('rnjkfemd',
          )));
    }
    return Scaffold(
      body: Builder(
          builder: (context) =>  SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 80.0),
                Column(
                  children: <Widget>[
                    // Image.asset('assets/diamond.png')
                    Icon(Icons.person_outline, size: 50.0),
                    SizedBox(height: 16.0),
                    Text('Create Account'),
                  ],
                ),
                SizedBox(height: 70.0),
                TextField(
                  controller: phone_numer,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.phone_android),
                    labelText: 'Phone number',
                  ),
                ),
                SizedBox(height: 12.0),
                TextField(
                  controller: mail_controller,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.mail),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 12.0),
                TextField(
                  controller: password_controller,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Create Account'),
                    ),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () async {
                      print('click');
                      await AuthService()
                          .register(
                          phone_numer.text.toString().trim(),
                          password_controller.text.toString().trim(),
                          mail_controller.text.toString().trim())
                          .then((val) => {
                        if (val.data['success'])
                          {
                            saveLogin(val.data['msg']),
                            Get.toNamed('/dashboard'),
                          }
                        else
                          {
                            showError()
                          }
                      })
                          .catchError((e) => {Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(e.toString()),
                      ))});
                    },
                  ),
                ),
                SizedBox(height: 32.0),
                FlatButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Already have an account? Login'))
              ],
            ),
          )
      ),
    );
  }

  saveLogin(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', token);
      print(prefs.getString('token'));
    });
  }
}

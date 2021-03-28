import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/Db/Model/LoginModel.dart';
import 'package:flutter_eats/Db/Services/AuthService.dart';
import 'package:flutter_eats/Db/bloc/LoginAuthBloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phone_number = TextEditingController();
  final password_controller = TextEditingController();
  Login login;
  LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                // Image.asset('assets/diamond.png')
                Icon(Icons.person_outline, size: 50.0),
                SizedBox(height: 16.0),
                Text('Login'),
              ],
            ),
            SizedBox(height: 70.0),
            TextField(
              controller: phone_number,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.phone_android),
                labelText: 'Phone number',
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
            CupertinoButton.filled(
              onPressed: () async {
                if(phone_number.text.toString().trim().length==10&&password_controller.text.toString().trim().length>5)
                  {
                    Get.snackbar('Logging in', 'processing request !',
                        showProgressIndicator: true,
                        snackPosition: SnackPosition.BOTTOM);
                    AuthService()
                        .login(phone_number.text.toString().trim(),
                        password_controller.text.toString().trim())
                        .then((val) => {
                      print(val),
                      if (val.data['success'])
                        {
                          saveLogin(val.data['msg']),
                          Get.offAndToNamed('/dashboard'),
                        }
                    })
                        .catchErr((e) => {Get.snackbar('Error', e.toString(),
                        snackPosition: SnackPosition.BOTTOM)
                    });
                  }
                else
                  {
                    Get.snackbar('Invalid request', 'Enter all fields !',
                        showProgressIndicator: true,
                        snackPosition: SnackPosition.BOTTOM);
                  }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 32.0),
            FlatButton(
                onPressed: () {
                  Get.toNamed('/signUp');
                },
                child: Text('Don\'t  have an account?Sign Up'))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // loginBloc = LoginBloc(login);
  }

  saveLogin(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', token);
      print(prefs.getString('token'));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:phnauth_and_qr/screens/login/login_form.dart';
import '../utils/utils.dart';

class LoginPage extends StatefulWidget {
  static const TAG = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              TopRightCircleDecoration(),
              ScaffoldBackgroundDecoration(),
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    HeaderText(text: 'LOGIN'),
                    SizedBox(height: 100),
                    LoginForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

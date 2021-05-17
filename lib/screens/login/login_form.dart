import 'package:flutter/material.dart';
import '../../services/firebase_services.dart';
import 'text_field.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final phoneKey = GlobalKey<FormState>();
  final smsKey = GlobalKey<FormState>();

  final phoneTextController = TextEditingController();
  final otpTextController = TextEditingController();

  bool smsSent = false;

  _onError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  _sendSmsCode() async {
    if (!phoneKey.currentState.validate()) return;
    await firebaseService.verifyPhoneNumber(phoneTextController.text, _onError);
    setState(() => smsSent = true);
  }

  _verifySmsCode() async {
    if (!smsKey.currentState.validate()) return;
    firebaseService.verifySmsCode(otpTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Phone number', style: TextStyle(fontSize: 20)),
          MyTextField(
            controller: phoneTextController,
            formKey: phoneKey,
            isPhone: true,
          ),
          _buildOtpWidget(),
          SizedBox(height: 50),
          _buildLoginButton(),
          SizedBox(height: 4),
          Center(
            child: TextButton(
              onPressed: () => setState(() => smsSent = !smsSent),
              child: Text(smsSent ? 'Switch back to Send OTP?' : 'Already have an OTP?'),
            ),
          ),
        ],
      ),
    );
  }

  _buildOtpWidget() {
    if (!smsSent) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Text('OTP', style: TextStyle(fontSize: 20)),
        MyTextField(controller: otpTextController, formKey: smsKey),
      ],
    );
  }

  _buildLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Color.fromRGBO(62, 62, 62, 1)),
      onPressed: smsSent ? _verifySmsCode : _sendSmsCode,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: Text(
          smsSent ? 'LOGIN' : 'Send OTP',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

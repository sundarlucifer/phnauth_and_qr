import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key key,
    @required this.controller,
    @required this.formKey,
  }) : super(key: key);

  final TextEditingController controller;
  final formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(border: InputBorder.none),
          keyboardType: TextInputType.phone,
          validator: (value) {
            return value.isEmpty ? 'Must not be empty' : null;
          },
        ),
      ),
    );
  }
}

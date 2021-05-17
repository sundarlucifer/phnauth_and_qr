import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key key,
    @required this.controller,
    @required this.formKey,
    this.isPhone = false,
  }) : super(key: key);

  final TextEditingController controller;
  final formKey;
  final bool isPhone;

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
            if(value.isEmpty)
              return 'Must not be empty';
            if(isPhone && !value.startsWith('+'))
              return 'Add country code ex: +91';
            return null;
          },
        ),
      ),
    );
  }
}

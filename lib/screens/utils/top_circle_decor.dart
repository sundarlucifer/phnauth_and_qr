import 'package:flutter/material.dart';

class TopRightCircleDecoration extends StatelessWidget {
  const TopRightCircleDecoration({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -40,
      right: -10,
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromRGBO(59, 59, 100, 1),
        ),
      ),
    );
  }
}
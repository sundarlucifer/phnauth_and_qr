import 'package:flutter/material.dart';

class PreviousQrCard extends StatelessWidget {
  const PreviousQrCard({
    Key key,
    @required this.previousNumber,
    @required this.previousUrl,
  }) : super(key: key);

  final previousNumber;
  final String previousUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(top: 50),
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromRGBO(18, 18, 18, 1),
        ),
        child: Row(
          children: [
            SizedBox(width: 130),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('PREVIOUSLY SCANNED',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
              SizedBox(height: 8),
              Text('$previousNumber', style: TextStyle(fontSize: 40)),
            ]),
          ],
        ),
      ),
      Positioned(
        bottom: 10,
        left: 10,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Image.network(previousUrl, width: 100, height: 100),
        ),
      ),
    ]);
  }
}

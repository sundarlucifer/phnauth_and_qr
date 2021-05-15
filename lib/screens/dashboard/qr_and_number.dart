import 'package:flutter/material.dart';

import 'qr_image.dart';

class QrCodeAndNumber extends StatelessWidget {
  const QrCodeAndNumber({
    Key key,
    @required this.qrKey,
    @required this.randomNumber,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> qrKey;
  final randomNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QrImageWidget(
          qrKey: qrKey,
          randomNumber: randomNumber,
        ),
        SizedBox(height: 20),
        Text(
          'Generated number',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        Text('$randomNumber',
            style: TextStyle(fontSize: 40)),
      ],
    );
  }
}

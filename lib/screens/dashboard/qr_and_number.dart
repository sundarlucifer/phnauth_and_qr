import 'package:flutter/material.dart';

import 'qr_image.dart';

const kNumberContainerSize = 160.0;

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
    return Stack(alignment: Alignment.topCenter, children: [
      Column(
        children: [
          SizedBox(height: kQrSize*0.8),
          Container(
            height: kNumberContainerSize,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(height: 60),
                Text(
                  'Generated number',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text('$randomNumber', style: TextStyle(fontSize: 40)),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
      QrImageWidget(
        qrKey: qrKey,
        randomNumber: randomNumber,
      ),
    ]);
  }
}

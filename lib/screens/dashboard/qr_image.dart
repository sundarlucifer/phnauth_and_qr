import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrImageWidget extends StatelessWidget {
  const QrImageWidget({
    Key key,
    @required this.qrKey,
    @required this.randomNumber,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> qrKey;
  final randomNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: RepaintBoundary(
        key: qrKey,
        child: QrImage(
          data: '$randomNumber',
          size: 200,
          padding: EdgeInsets.all(16),
          errorStateBuilder: (context, error) {
            print("[QR] ERROR - $error");
            return Text('$error');
          },
        ),
      ),
    );
  }
}

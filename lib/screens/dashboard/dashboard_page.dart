import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../utils/utils.dart';
import 'package:phnauth_and_qr/services/firebase_services.dart';

import 'previous_qr.dart';
import 'qr_image.dart';

class DashboardPage extends StatefulWidget {
  static const TAG = 'dashboard-page';

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final qrKey = new GlobalKey();
  var randomNumber;
  var previousNumber;
  String previousUrl;

  bool _isLoading = false;
  bool _isPreviousPresent = false;

  @override
  void initState() {
    super.initState();
    randomNumber = random();
    _checkPreviouslyScanned();
  }

  _checkPreviouslyScanned() async {
    final data = await firebaseService.getPreviouslyScannedNumber();
    if (data != null) {
      setState(() {
        _isPreviousPresent = true;
        previousNumber = data['random_number'];
        previousUrl = data['qr_url'];
      });
    }
  }

  random() {
    final min = 100000;
    final max = 999999;
    return min + Random().nextInt(max - min);
  }

  _saveNumberAndQr() async {
    String message = 'Saved successfully!';
    setState(() => _isLoading = true);
    RenderRepaintBoundary qrBoundary = qrKey.currentContext.findRenderObject();
    final image = await qrBoundary.toImage();
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    try {
      await firebaseService.saveNumberAndQr(randomNumber, pngBytes);
    } catch (e) {
      message = e;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Stack(
                  children: [
                    TopRightCircleDecoration(),
                    _buildLogoutButton(),
                    ScaffoldBackgroundDecoration(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(height: 60),
                          HeaderText(text: 'PLUGIN'),
                          SizedBox(height: 50),
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
                          Text('$randomNumber', style: TextStyle(fontSize: 40)),
                          _buildPreviousQr(),
                          Spacer(),
                          _buildSaveButton(),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  _buildLogoutButton() {
    return Positioned(
      right: 0,
      child: TextButton(
        onPressed: firebaseService.logout,
        child: Text(
          'Logout',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  _buildPreviousQr() {
    if (!_isPreviousPresent) return SizedBox();

    return PreviousQrCard(
      previousNumber: previousNumber,
      previousUrl: previousUrl,
    );
  }

  _buildSaveButton() {
    return ElevatedButton(
      onPressed: _saveNumberAndQr,
      style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(62, 62, 62, 1),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: Text(
          'SAVE',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

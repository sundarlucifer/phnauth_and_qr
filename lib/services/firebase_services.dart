import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Stream<User> get authState => _auth.authStateChanges();

  String verificationId = '';

  Future<void> verifyPhoneNumber(String phoneNumber, Function onError) {
    return _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: _signInWithCredential,
      verificationFailed: (e) => _verificationFailed(e, onError),
      codeSent: (String verificationId, int resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }

  _verificationFailed(FirebaseAuthException e, Function onError) {
    print(e.message);
    onError(e.code);
  }

  _signInWithCredential(PhoneAuthCredential credential) {
    _auth.signInWithCredential(credential).catchError((e) {
      print(e);
    });
  }

  verifySmsCode(String smsCode) {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    _signInWithCredential(credential);
  }

  Future saveNumberAndQr(randomNumber, Uint8List pngBytes) async {
    await _writeNumberToDb(randomNumber);
    return await _uploadImageToStorage(pngBytes);
  }

  _writeNumberToDb(randomNumber) async {
    return await _db
        .collection('numbers')
        .doc(_auth.currentUser.uid)
        .set({'random_number': randomNumber});
  }

  _uploadImageToStorage(Uint8List pngBytes) async {
    final ref = _storage.ref('qr_images/${_auth.currentUser.uid}.png');
    return await ref.putData(pngBytes);
  }

  Future<Map<String, dynamic>> getPreviouslyScannedNumber() async {
    final snapshot = await _db.collection('numbers').doc(_auth.currentUser.uid).get();
    if(!snapshot.exists) {
      return null;
    }
    final ref = _storage.ref('qr_images/${_auth.currentUser.uid}.png');
    final url = await ref.getDownloadURL();
    final data = snapshot.data();
    data['qr_url'] = url;
    return data;
  }

  logout() {
    _auth.signOut();
  }
}

final firebaseService = FirebaseService();

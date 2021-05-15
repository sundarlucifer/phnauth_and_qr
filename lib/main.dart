import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'data/constants.dart';
import 'screens/dashboard/dashboard_page.dart';
import 'screens/loading_page.dart';
import 'screens/login/login_page.dart';
import 'services/firebase_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _routes = <String, WidgetBuilder>{
    DashboardPage.TAG: (_) => DashboardPage(),
    LoginPage.TAG: (_) => LoginPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhnAuth and QR',
      debugShowCheckedModeBanner: false,
      theme: APP_THEME,
      home: StreamBuilder(
        stream: firebaseService.authState,
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingPage();
          else
            return snapshot.data != null ? DashboardPage() : LoginPage();
        },
      ),
      routes: _routes,
    );
  }
}

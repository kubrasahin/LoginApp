import 'package:flutter/material.dart';
import 'package:loginproject/screens/auth/login.dart';
import 'package:loginproject/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  Future<String?> getToken() async {
    SharedPreferences token = await SharedPreferences.getInstance();
    return token.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Aplication',
      home: FutureBuilder<String?>(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            String? tokenn = snapshot.data;
            return tokenn == null ? LoginScreen() : HomeScreen();
          }
        },
      ),
    );
  }
}

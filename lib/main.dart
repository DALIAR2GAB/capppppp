import 'package:capppppp/providers/coach.dart';
import 'package:capppppp/providers/doctor.dart';
import 'package:capppppp/providers/homepage.dart';
import 'package:capppppp/providers/login.dart';
import 'package:capppppp/providers/notifaction.dart';
import 'package:capppppp/providers/posts.dart';
import 'package:capppppp/providers/signup.dart';
import 'package:capppppp/providers/userprovidr.dart';
import 'package:capppppp/providers/vodafone.dart';

import 'package:capppppp/screen/login.dart';
import 'package:capppppp/screen/signup.dart';
import 'package:capppppp/screen/welcomepage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'serviecs/signup.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()), // جعل UserProvider متاحًا
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => CoachProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => DoctorProvider ()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => VodafoneCashProvider()),
        ChangeNotifierProvider(create: (_) => PostProviderr()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}

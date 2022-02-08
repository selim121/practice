import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:history/services/auth_service.dart';
import 'package:history/views/home_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthService().get0rCreateUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomeView(),
    );
  }
}


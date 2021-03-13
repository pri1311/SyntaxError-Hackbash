<<<<<<< HEAD
import 'package:earthling/screens/PMI_calculator.dart';
=======
import 'package:earthling/screens/main_screen.dart';
>>>>>>> 1ad3ae08d1510471d32c1112e66fe231feaff8fa
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      home: PMI_calculator(),
=======
      home: MainScreen(),
>>>>>>> 1ad3ae08d1510471d32c1112e66fe231feaff8fa
    );
  }
}

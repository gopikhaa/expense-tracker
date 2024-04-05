import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:expense_tracker/auth/authPage.dart';
import 'package:flutter/services.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAxh9F489Y0p4aohYz7QAU0eBLpX0Y-h6c",
          appId: "com.lbscollege.expense_tracker",
          messagingSenderId: "054523858923",
          projectId: "expense-tracker-58996"));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MoneyManager()));
}

class MoneyManager extends StatefulWidget {
  MoneyManager({Key? key}) : super(key: key);

  @override
  _MoneyManagerState createState() => _MoneyManagerState();
}

class _MoneyManagerState extends State<MoneyManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: AuthPage(),
    );
  }
}

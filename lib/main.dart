import 'package:expense_tracker/services/pages/others/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

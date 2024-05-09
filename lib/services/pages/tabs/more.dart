import 'package:expense_tracker/services/pages/others/currency_converter.dart';
import 'package:expense_tracker/services/pages/others/splash_screen.dart';
import 'package:expense_tracker/network/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_tracker/services/pages/tabs/categoryPage.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  var box = GetStorage();

  var emailId = "";

  @override
  void initState() {
    box = GetStorage();
    emailId = box.read("emailId").toString();

    fetchExchangeRates();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/icon/user.png'),
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              emailId,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 29, 50, 118),
              ),
            ),
            SizedBox(height: 20),
            customCards('assets/icon/category.png', 'Category', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryPage(),
                ),
              );
            }),
            customCards(Icons.currency_exchange, "Currecny Converter", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CurrencyConverter(),
                ),
              );
            }),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Color.fromARGB(255, 6, 41, 154),
                ),
                child: GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    box.erase();
                    box.write("default", false);
                    Get.offAll(const SplashScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/icon/logout.png',
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Sign Out",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customCards(imgPath, label, btnClick) {
    return GestureDetector(
      onTap: btnClick,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Color.fromARGB(255, 6, 41, 154),
          child: ListTile(
            leading: (label == "Currecny Converter")
                ? Icon(imgPath, color: Colors.white)
                : Image.asset(
                    imgPath,
                    height: 30,
                    color: Colors.white,
                  ),
            title: Text(label,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }
}

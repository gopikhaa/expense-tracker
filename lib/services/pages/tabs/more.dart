import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:expense_tracker/services/pages/reusable/iconButtonText.dart';
import 'package:expense_tracker/services/pages/reusable/customIcon.dart';
import 'package:gap/gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_tracker/services/pages/tabs/categoryPage.dart';
import 'package:expense_tracker/services/pages/tabs/feedback.dart';
import 'package:expense_tracker/services/pages/tabs/personalPage.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButtonText(
                  fun: () {},
                  label: 'Settings',
                  icon: CustomIcon(imagePath: 'assets/icon/setting.png'),
                ),
                IconButtonText(
                  fun: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PasswordChangePage(),
                      ),
                    );
                  },
                  label: 'Personal',
                  icon: CustomIcon(
                    imagePath: 'assets/icon/personal.png',
                  ),
                ),
                IconButtonText(
                  fun: () {},
                  label: 'Style',
                  icon: CustomIcon(imagePath: 'assets/icon/style.png'),
                ),
              ],
            ),
            const Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButtonText(
                  fun: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedBack(),
                    ),
                  ),
                  label: 'Feedback',
                  icon: CustomIcon(imagePath: 'assets/icon/feedback.png'),
                ),
                IconButtonText(
                  fun: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(),
                      ),
                    );
                  },
                  label: 'Category',
                  icon: CustomIcon(imagePath: 'assets/icon/category.png'),
                ),
                IconButtonText(
                  fun: () {
                    FirebaseAuth.instance.signOut();
                    GoogleSignIn().signOut();
                    GoogleSignIn().disconnect();
                  },
                  label: 'Sign Out',
                  icon: CustomIcon(imagePath: 'assets/icon/logout.png'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

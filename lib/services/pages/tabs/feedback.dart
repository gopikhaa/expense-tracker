import 'package:flutter/material.dart';
import 'package:expense_tracker/services/functions/sentEmail.dart';
import 'package:expense_tracker/services/pages/reusable/auth/authButton.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/services/pages/reusable/defaultFeedback.dart';

class FeedBack extends StatefulWidget {
  FeedBack({Key? key}) : super(key: key);

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final _feedbackController = TextEditingController();
  void _changeFeedback(String text) {
    setState(() {
      _feedbackController.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultFeedback(
                    onTap: () => _changeFeedback('App very good'),
                    feedback: 'App very good'),
                DefaultFeedback(
                    onTap: () => _changeFeedback('5 stars'),
                    feedback: '5 stars'),
                DefaultFeedback(
                    onTap: () => _changeFeedback('Love youu'),
                    feedback: 'Love youu'),
              ],
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultFeedback(
                    onTap: () => _changeFeedback('App very badd'),
                    feedback: 'App very badd'),
                DefaultFeedback(
                    onTap: () => _changeFeedback('2 stars'),
                    feedback: '2 stars'),
                DefaultFeedback(
                    onTap: () => _changeFeedback('Delete app'),
                    feedback: 'Delete app'),
              ],
            ),
            const Gap(50),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write your feedback here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            AuthButton(
              buttonText: 'Send Feedback',
              fun: () {},
            ),
          ],
        ),
      ),
    );
  }
}

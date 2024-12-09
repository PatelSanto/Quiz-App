import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/const/colors.dart';
import 'package:quiz_app/const/images.dart';
import 'package:quiz_app/const/text_style.dart';
import 'package:quiz_app/quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const QuizApp(),
      theme: ThemeData(
        fontFamily: 'quick',
      ),
      title: 'Demo',
    );
  }
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [blue, darkBlue],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Lottie.network(
                    "https://assets7.lottiefiles.com/packages/lf20_ayopewsc.json"),
              ),
              SizedBox(
                height: 50,
              ),
              normalText(color: lightgrey, size: 28, text: 'Welcome to our'),
              headingText(color: Colors.white, size: 38, text: 'Quiz App'),
              normalText(
                  color: lightgrey,
                  size: 20,
                  text:
                      'Do you feel Confident? \nHere you will face our most difficult questions!'),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    width: size.width - 100,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: headingText(color: blue, size: 18, text: 'Continue'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

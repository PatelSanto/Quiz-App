import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/const/text_style.dart';
import 'package:quiz_app/quiz_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.pointData});

  final int pointData;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Lottie.network(
            "https://assets9.lottiefiles.com/private_files/lf30_9142zhsb.json"),
        headingText(text: 'Congartulations!', size: 30, color: Colors.red),
        normalText(
            text: 'Your Score is  out of 200', size: 15, color: Colors.green)
      ]),
    );
  }
}

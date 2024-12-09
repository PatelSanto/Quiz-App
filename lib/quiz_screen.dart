import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/api_services.dart';
import 'package:quiz_app/const/colors.dart';
import 'package:quiz_app/const/images.dart';
import 'package:quiz_app/const/text_style.dart';
import 'package:quiz_app/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int seconds = 60;
  Timer? timer;
  var currentQuestionsindex = 0;
  late Future quiz;
  int points = 0;

  var isLoaded = false;

  var optionsList = [];
  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    quiz = getQuiz();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

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
              child: FutureBuilder(
                future: quiz,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data["results"];

                    if (isLoaded == false) {
                      optionsList =
                          data[currentQuestionsindex]["incorrect_answers"];
                      optionsList
                          .add(data[currentQuestionsindex]["correct_answer"]);
                      optionsList.shuffle();
                      isLoaded = true;
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      Border.all(color: lightgrey, width: 2),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  normalText(
                                      color: Colors.white,
                                      size: 24,
                                      text: '$seconds'),
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator(
                                      value: seconds / 60,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      Border.all(color: lightgrey, width: 2),
                                ),
                                child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  label: normalText(
                                      color: Colors.white,
                                      size: 16,
                                      text: 'Like'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset(answer, width: 200),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: normalText(
                                  color: lightgrey,
                                  size: 18,
                                  text:
                                      'Question ${currentQuestionsindex + 1} of ${data.length}')),
                          const SizedBox(height: 20),
                          normalText(
                              color: Colors.white,
                              size: 20,
                              text: data[currentQuestionsindex]["question"]),
                          const SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: optionsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var answer =
                                  data[currentQuestionsindex]["correct_answer"];

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (answer.toString() ==
                                        optionsList[index].toString()) {
                                      optionsColor[index] = Colors.green;
                                      points = points + 10;
                                    } else {
                                      optionsColor[index] = Colors.red;
                                    }

                                    if (currentQuestionsindex <
                                        data.length - 1) {
                                      Future.delayed(Duration(milliseconds: 20),
                                          () {
                                        isLoaded = false;
                                        currentQuestionsindex++;
                                        resetColors();
                                        timer!.cancel();
                                        seconds = 60;
                                        startTimer();
                                      });
                                    } else if (currentQuestionsindex <
                                        data.length - 1) {
                                      timer!.cancel();
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ResultScreen(pointData: points),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  alignment: Alignment.center,
                                  width: size.width - 100,
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: optionsColor[index],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: headingText(
                                      color: blue,
                                      size: 18,
                                      text: optionsList[index].toString()),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  }
                },
              ))),
    );
  }
}

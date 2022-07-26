import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_brain.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Quiz App"),
          centerTitle: true,
        ),
        body: const MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  QuizBrain quizBrainer = QuizBrain();

  String result(int x) {
    double y = (x / 13 * 100);
    String z = y.toString();
    return z;
  }

  alertBuilder() {
    if (quizBrainer.lastQuestion) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    setState(() {
                      quizBrainer.score = 0;
                      quizBrainer.scoreKeeper.clear();
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("Back"))
            ],
            title: const Text("Game Over"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [Text("You Scored ${result(quizBrainer.score)}")],
              ),
            ),
            elevation: 100,
            backgroundColor: double.parse(
                      result(quizBrainer.score),
                    ) >
                    50
                ? Colors.green
                : Colors.red,
            // shape: const CircleBorder(
            //   side: BorderSide(width: 1),
            // ),
          );
        },
        barrierDismissible: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Column(children: [
          Expanded(
            flex: 8,
            child: Center(
              child: Text(
                // questions[index],
                // questionBank[index].questionText,
                quizBrainer.getquestion(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () => setState(() {
                  quizBrainer.answerMarker(true);
                  quizBrainer.lastQuestionChecker();
                  alertBuilder();
                }),
                child: const Center(child: Text("True")),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                color: Colors.red,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () => setState(() {
                    // if (answers[index] == false) {
                    quizBrainer.answerMarker(false);
                    // if (questions.length - 1 == index) {
                    quizBrainer.lastQuestionChecker();
                    alertBuilder();
                  }),
                  child: const Center(
                    child: Text("False"),
                  ),
                ),
              ),
            ),
          ),
          Wrap(
              // scrollDirection: Axis.horizontal,

              // mainAxisAlignment: MainAxisAlignment.center,
              children: quizBrainer.scoreKeeper),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  /// The Answer Buttons ///
  Widget answerButton({required Color color, required Widget child}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
            child: child,
            onPressed: () {
              bool correctAnswer = quizBrain.getCorrectAnswer();
              setState(() {
                // Check if the user's answer is correct and update scoreKeeper
                if (correctAnswer == (color == Colors.green)) {
                  scoreKeeper.add(
                    const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  );
                } else {
                  scoreKeeper.add(
                    const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  );
                }

                // Move to the next question or finish the quiz
                if (quizBrain.isFinished()) {
                  Alert(
                    context: context,
                    title: 'Quiz Completed',
                    desc: 'You have completed the quiz!',
                    buttons: [
                      DialogButton(
                        child: const Text(
                          "Restart",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            quizBrain.reset();
                            scoreKeeper
                                .clear(); // Clear scoreKeeper to reset icons
                          });
                        },
                      )
                    ],
                  ).show();
                } else {
                  quizBrain.nextQuestion();
                }
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              quizBrain.getQuestionText(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // Use `answerButton` here for "True"
        answerButton(
          color: Colors.green,
          child: const Text(
            'True',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),

        // Use `answerButton` here for "False"
        answerButton(
          color: Colors.red,
          child: const Text(
            'False',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),

        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

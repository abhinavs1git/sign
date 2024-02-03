// ignore_for_file: use_key_in_widget_constructors

import 'package:sign/utils/color_utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _questionIndex = 0;
  int _totalScore = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'questionText': 'What is the real name of the Developer?',
      'options': <String>['Dhruv', 'Abhinav', 'Kartik', 'Kavya'],
      'correctAnswer': 'Abhinav',
    },
    {
      'questionText': 'Where does the Developer hail from?',
      'options': <String>['Delhi', 'Allahabad', 'Lucknow', 'Jaipur'],
      'correctAnswer': 'Lucknow',
    },
    {
      'questionText': "What is the tech domain the Developer in engaged in?",
      'options': <String>[
        'Web Development',
        'Cyber Security',
        'Machine Learning',
        'App Development',
      ],
      'correctAnswer': 'App Development',
    },
    {
      'questionText':
          'What are the things the Developer likes to do in free time?',
      'options': <String>['Cycling', 'Poetry', 'Singing', 'Anime'],
      'correctAnswer': 'Poetry',
    },
    {
      'questionText':
          "What is the thing that might be in the Developer's Bucket list?",
      'options': <String>[
        'A visit to Norway',
        'A Solo Bike Trip',
        'Having a 9 CGPA semester',
        'Any Adraneline sport'
      ],
      'correctAnswer': 'A visit to Norway',
    },
  ];

  void _answerQuestion(String selectedAnswer) {
    if (_questions[_questionIndex]['correctAnswer'] == selectedAnswer) {
      _totalScore += 5;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: hexStringToColor('AA4B6B'),
          content: const Text('Right On +5 points!'),
          duration: const Duration(milliseconds: 850),
        ),
      );
    }
    setState(() {
      _questionIndex++;
    });

    if (_questionIndex == _questions.length) {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Quiz Result',
            style: TextStyle(
                color: Colors.white.withOpacity(01),
                fontWeight: FontWeight.bold),
          ),
          content: Text('You scored $_totalScore out of 25 points.',
              style: const TextStyle(color: Colors.white)),
          backgroundColor: hexStringToColor('3B8D99'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _questionIndex = 0;
                  _totalScore = 0;
                });
              },
              child: const Text(
                'Try Again',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Developer Quiz',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("AA4B6B"),
              hexStringToColor("757F9A"),
              hexStringToColor("3B8D99")
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, MediaQuery.of(context).size.height * 0.2, 20, 5),
                    child: Column(children: <Widget>[
                      const SizedBox(height: 60),
                      Center(
                          child: _questionIndex < _questions.length
                              ? Quiz(
                                  questionText: _questions[_questionIndex]
                                      ['questionText'],
                                  options: List<String>.from(
                                      _questions[_questionIndex]['options']),
                                  answerQuestion: _answerQuestion,
                                )
                              : const Center(
                                  child: Text(
                                    "You've completed the quiz!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                    ])))));
  }
}

class Quiz extends StatelessWidget {
  final String questionText;
  final List<String> options;
  final Function(String) answerQuestion;

  const Quiz({
    required this.questionText,
    required this.options,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            questionText,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ...options.map((option) => OptionButton(
              option: option,
              selectOption: answerQuestion,
            )),
      ],
    );
  }
}

class OptionButton extends StatelessWidget {
  final String option;
  final Function(String) selectOption;

  const OptionButton({
    required this.option,
    required this.selectOption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.black54,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              minimumSize: const Size(360, 70)),
          onPressed: () => selectOption(option),
          child: Text(
            option,
            style:
                TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:app_quizzz/FinalScoreScreen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  int elapsedSeconds = 30;
  Timer? timer;

  List<String> questions = [
    'Qual a linguagem de programação mais utilizada atualmente?',
    'O que significa a sigla HTML?',
    'Qual o nome do fundador da Apple?',
    'Qual a versão mais recente do sistema operacional Android?',
    'Qual é o método HTTP utilizado para enviar dados em um formulário HTML?',
    'O que significa a sigla CSS?',
    'Qual linguagem de programação é utilizada para estilizar páginas web?',
    'Qual dos seguintes não é um framework JavaScript?',
    'O que significa a sigla API?',
    'Qual tecnologia é usada para estilizar a aparência de elementos HTML?',
    'Qual é o elemento HTML usado para criar uma lista numerada?',
    'Qual dos seguintes é um banco de dados relacional?',
    'O que significa a sigla URL?',
    'Qual dos seguintes é um servidor web popular?',
    'Qual dos seguintes é um editor de código-fonte gratuito e de código aberto?',
    'O que significa a sigla DNS?',
    'Qual é o nome da linguagem de programação usada para desenvolvimento de aplicações mobile com Flutter?',
    'Qual dos seguintes não é um sistema de controle de versão?',
    'O que significa a sigla JSON?',
    'O que é o protocolo HTTPS?'
  ];

  List<List<String>> options = [
    ['JavaScript', 'Python', 'Java', 'C#'],
    ['HyperText Markup Language', 'High Tech Markup Language', 'HyperText Markdown Language', 'High Tech Markdown Language'],
    ['Steve Jobs', 'Steve Wozniak', 'Bill Gates', 'Mark Zuckerberg'],
    ['Android 10', 'Android 11', 'Android 12', 'Android 13'],
    ['GET', 'POST', 'PUT', 'DELETE'],
    ['Cascading Style Sheets', 'Creative Style Sheets', 'Computer Style Sheets', 'Cascading Script Styles'],
    ['CSS', 'HTML', 'JavaScript', 'Python'],
    ['React', 'Angular', 'Vue', 'Java'],
    ['Application Programming Interface', 'Advanced Programming Interface', 'Automated Program Interface', 'Application Process Interface'],
    ['CSS', 'HTML', 'JavaScript', 'Python'],
    ['ul', 'ol', 'li', 'div'],
    ['MySQL', 'MongoDB', 'SQLite', 'Firebase'],
    ['Uniform Resource Locator', 'Universal Resource Locator', 'Unique Resource Locator', 'Unified Resource Locator'],
    ['Apache', 'Nginx', 'IIS', 'Tomcat'],
    ['Visual Studio Code', 'Sublime Text', 'Atom', 'Eclipse'],
    ['Domain Name System', 'Domain Network Server', 'Dynamic Name System', 'Digital Network Service'],
    ['Dart', 'Java', 'Swift', 'Kotlin'],
    ['Git', 'SVN', 'Mercurial', 'TFS'],
    ['JavaScript Object Notation', 'Java Syntax Object Notation', 'JSON Scripted Object Notation', 'Java Serialized Object Notation'],
    ['versão mais rápida do HTTP', 'protocolo de segurança para transferência de dados', 'extensão do protocolo FTP', 'protocolo para acesso remoto']
  ];

  List<int> selectedQuestions = [];

  void generateRandomQuestions() {
    selectedQuestions = [];
    final random = Random();
    while (selectedQuestions.length < 10) {
      int randomIndex = random.nextInt(questions.length);
      if (!selectedQuestions.contains(randomIndex)) {
        selectedQuestions.add(randomIndex);
      }
    }
    currentQuestion = 0;
    score = 0;
    elapsedSeconds = 30;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (elapsedSeconds > 0) {
          elapsedSeconds--;
        } else {
          stopTimer();
          checkAnswer(-1); // Encerra o jogo quando o tempo acabar
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void checkAnswer(int selectedIndex) {
    setState(() {
      stopTimer(); // Pausa o cronômetro
      if (selectedIndex == correctAnswerIndex()) {
        score++;
      }
      if (currentQuestion < selectedQuestions.length - 1) {
        currentQuestion++;
        elapsedSeconds = 30; // Reinicia o tempo para a próxima pergunta
        startTimer();
      } else {
        Future.delayed(Duration(milliseconds: 500), () {
          navigateToFinalScore();
        });
      }
    });
  }

  void navigateToFinalScore() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinalScoreScreen(score: score),
      ),
    );
  }

  int correctAnswerIndex() {
    int questionIndex = selectedQuestions[currentQuestion];
    String currentQuestionAnswer = options[questionIndex][0];
    return options[questionIndex].indexOf(currentQuestionAnswer);
  }

  void restartQuiz() {
    setState(() {
      generateRandomQuestions();
    });
  }

  @override
  void initState() {
    super.initState();
    generateRandomQuestions();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/img/img.png',
            ),
            SizedBox(height: 4.0),
            Text(
              'Tempo: 00:0$elapsedSeconds ',
              style: TextStyle(
                fontSize: 16.0,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              width: 500,
              height: 100,
              color: Colors.black12,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                questions[selectedQuestions[currentQuestion]],
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10.0),
            Column(
              children: options[selectedQuestions[currentQuestion]]
                  .asMap()
                  .entries
                  .map(
                    (option) => ElevatedButton(
                  child: Text(
                    option.value,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  onPressed: () {
                    checkAnswer(option.key);
                  },
                ),
              )
                  .toList(),
            ),
            SizedBox(height: 5.0),
            Text(
              'Pontuação: $score/10',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            if (currentQuestion == selectedQuestions.length - 1)

              SizedBox(height: 5.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
              ),
              child: Text('voltar '),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

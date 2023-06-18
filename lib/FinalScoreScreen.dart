import 'package:flutter/material.dart';

class FinalScoreScreen extends StatelessWidget {
  final int score;

  FinalScoreScreen({required this.score});

  String getScoreMessage() {
    if (score <= 3) {
      return 'Você foi ruim!';
    } else if (score <= 5) {
      return 'Você pode melhorar!';
    } else if (score <= 7) {
      return 'Bom!';
    } else {
      return 'Ótimo!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pontuação Final'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sua pontuação final: $score/10',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              getScoreMessage(),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Voltar ao aplicativo'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:app_quizzz/app.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remover o banner de "Debug"
      home: MyHomePage(
      ),
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[
            Image.asset('assets/img/img.png',),

            SizedBox(height: 100),
            Text(   textAlign: TextAlign.center,

                '"Venha testar seus conhecimentos e se divertir no nosso incrível Quizz!'
                    'Desafie-se e descubra o quanto você sabe sobre Tecnologia. Convide seus amigos'
                    ' e participe agora mesmo! Estamos esperando por você, Vamos começar?"',

                style: TextStyle(fontSize: 16.0, color: Colors.blueGrey,
                  letterSpacing: 2.5,fontStyle: FontStyle.italic,

                )
            ),
            SizedBox(height: 100),
            Container(
              width: 200,
              height: 100,
              child: ElevatedButton(

                child: const Icon(Icons.play_circle_outline,color: Colors.white,size: 30,),

                onPressed: () {

                  var push = Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tez_bdt/ui/view/depressionTest/questions.dart';

class QuestionStart extends StatefulWidget {
  @override
  _QuestionStartState createState() => _QuestionStartState();
}

class _QuestionStartState extends State<QuestionStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[200],
      ),
       
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _questionBox(),
            MaterialButton(
              focusElevation: double.infinity,
              colorBrightness: Brightness.light,
              onPressed: startQuiz,
              height: 50.0,
              color: Colors.blueAccent,
              child: Text(
                "Teste Başlamak İçin Tıklayınız",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void startQuiz() {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Questions()));
    });
  }

  Widget _questionBox() {
    return Container(
      
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 50.0),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.blue[200])),
      child: _text(),
    );
  }

  Widget _text() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(
        startsentences,
        style: TextStyle(fontSize: 14.0, color: Colors.black),
        textAlign:TextAlign.center,
        
      ),
    );
  }

  var startsentences =
      "Son bir hafta içindeki (şu an dahil) kendi ruh durumunuzu gözönünde bulundurarak, size en uygun olan ifadeyi seçiniz.";
}

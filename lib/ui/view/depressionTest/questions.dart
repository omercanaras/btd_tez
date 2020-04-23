import 'package:flutter/material.dart';
import 'package:tez_bdt/core/model/user/test_model.dart';
import 'package:tez_bdt/localdata/local_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tez_bdt/ui/view/home/home_view.dart';

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {

  
 

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blueAccent[200],
            title: Text("Beck Testi"),
          ),
          backgroundColor: Colors.white,
          body: _questionsContainer(),
        ));
  }

  Widget _questionsContainer() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _questionBox0(),
          _questionBox1(),
          _questionBox2(),
          _questionBox3()
        ],
      ),
    );
  }

  Widget _questionBox0() {
    return InkWell(
      onTap: () {
        finalScore=finalScore;
        updateQuestion();
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blue[200])),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            question.choices[questionNumber][0],
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _questionBox1() {
    return InkWell(
      onTap: () {
        finalScore = finalScore + 1;
        updateQuestion();
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.blue[200]),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            question.choices[questionNumber][1],
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _questionBox2() {
    return InkWell(
      onTap: () {
        finalScore = finalScore + 2;
        updateQuestion();
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blue[200])),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            question.choices[questionNumber][2],
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _questionBox3() {
    return InkWell(
      onTap: () {
        finalScore = finalScore + 3;
        updateQuestion();
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blue[200])),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            question.choices[questionNumber][3],
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _exQuestionBox() {
    return Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              question.choices[questionNumber][2],
              style: TextStyle(fontSize: 14.0, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          alignment: Alignment.center,
          width: double.infinity,
          height: 100.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.white)),
        ));
  }
 

  void updateQuestion() {
    setState(() {
      if (questionNumber == 20) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Summary(
                      score: finalScore,
                    )));
      } else {
        questionNumber++;
      }
    });
  }

}

class Summary extends StatelessWidget {
  final db = Firestore.instance;
  final int score;
  Summary({Key key, @required this.score}) : super(key: key);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final testpoint= new TestPoint(null, null);
  
  @override
  Widget build(BuildContext context) {
    
  
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Test Sonucunuz: $finalScore",
                style: new TextStyle(fontSize: 35.0),
              ),
              Center(child: new Padding(padding: EdgeInsets.all(30.0))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new MaterialButton(
                    color: Colors.red,
                    onPressed: () {
                      questionNumber = 0;
                      finalScore = 0;
                      Navigator.pop(context);
                    },
                    child: new Text(
                      "Tekrar",
                      style: new TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                  new MaterialButton(
                    color: Colors.blueAccent,
                    onPressed: () async {
                      testpoint.point=finalScore;
                      testpoint.time=DateTime.now();
                      
                      final currentuser = await _firebaseAuth.currentUser();

                      await db
            .collection("userData")
            .document(currentuser.uid)
            .collection("testpoint")
            .add(testpoint.toJson());

                    },
                    child: new Text(
                      "Kaydet",
                      style: new TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  )
                ],
              ),
             
              SizedBox(height:15.0), 
              new MaterialButton(
                    color: Colors.orangeAccent,
                    onPressed: () {
                      questionNumber = 0;
                      finalScore = 0;
                        Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    child: new Text(
                      "Ana menü",
                      style: new TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tez_bdt/core/helper/shared_manager.dart';

import 'package:tez_bdt/core/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tez_bdt/core/services/firebase_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';





class ThoughtRecord extends StatefulWidget {
  @override
  _ThoughtRecordState createState() => _ThoughtRecordState();
}

// Düzeltme yapılıcak düşünce hataları ve hissedilen duygular arasında tabloya karar vermek gerekiyor.

class _ThoughtRecordState extends State<ThoughtRecord> {
  FirebaseService service = FirebaseService();

  final db = Firestore.instance;

  List<Feeling> _feelings;
  bool _isSelected;
  List<String> _filters;
  List<String> _filters2;
  User user;
  
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final rethought = new ReThought(null, null, null, null, null,null);

  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  List<Thought> _thoughtfails;

  @override
  void initState() {
    super.initState();
    _thoughtfails = <Thought>[
      Thought("Aşırı Genellemek"),
      Thought("Kutuplaştırmak"),
      Thought("Etiketlemek"),
      Thought("Kişiselleştirmek"),
      Thought("Felaketleştirmek"),
      Thought("Meli/Malı"),
      Thought("Zihin Okuma"),
      Thought("Falcılık"),
    ];
    _filters = [];
    _filters2 = [];

    _feelings = <Feeling>[
      Feeling("Üzgün"),
      Feeling("Kaygılı"),
      Feeling("Suçlu"),
      Feeling("Aşağı"),
      Feeling("Değersiz"),
      Feeling("Yetersiz"),
      Feeling("Yalnız"),
      Feeling("Mahcup"),
      Feeling("İstenmeyen"),
      Feeling("Kötü niyetli"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Düşünce Kayıt Sistemi"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            children: <Widget>[
              textContainer(),
              feelingemotion(),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 500),
                      child: Wrap(children: feelingWidgets.toList()))),
              Divider(
                color: Colors.blueAccent[200],
                indent: 22.0,
                endIndent: 22.0,
              ),
              textContainer2(),
              thoughtfail(),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 500),
                      child: Wrap(children: thoughtWidgets.toList()))),
              Divider(
                color: Colors.blueAccent[200],
                indent: 22.0,
                endIndent: 22.0,
              ),
              textContainer3(),
              Divider(
                color: Colors.black26,
                thickness: 1.4,
              ),
              SizedBox(height: 8),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buttonWidget(),
                    buttonWidget2(),
                  ],
                ),
              ),
              SizedBox(height: 8)
            ],
          ),
        ),
      ),
    );
  }

  Widget textContainer() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.done,
        maxLines: 4,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            labelText: "Durum",
            hintText: "Ne oldu? Nerede? Ne zaman? Kiminle? Nasıl?",
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget textContainer2() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller2,
        textInputAction: TextInputAction.done,
        maxLines: 4,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            labelText: "Otomatik Düşünceler",
            hintText: "Zihnimden neler geçti?",
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget textContainer3() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller3,
        textInputAction: TextInputAction.done,
        maxLines: 4,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            labelText: "Alternatif/Mantıklı Yanıt",
            hintText:
                "Başka şekilde bakılabilir mi? Bir başkası olsaydı ona ne tavsiye ederdim?",
            border: OutlineInputBorder()),
        onChanged: (text) {
          setState(() {});
        },
      ),
    );
  }

  Iterable<Widget> get feelingWidgets sync* {
    for (Feeling feeling in _feelings) {
      yield Padding(
        padding: EdgeInsets.only(right: 4.0),
        child: FilterChip(
          disabledColor: Colors.blueAccent,
          backgroundColor: Colors.white,
          shape: StadiumBorder(side: BorderSide(color: Color(0xFFDADADA))),
          label: Text(feeling.name),
          selected: _filters.contains(feeling.name),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(feeling.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == feeling.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  Iterable<Widget> get thoughtWidgets sync* {
    for (Thought thought in _thoughtfails) {
      yield Padding(
        padding: EdgeInsets.only(right: 4.0),
        child: FilterChip(
          disabledColor: Colors.blueAccent,
          backgroundColor: Colors.white,
          shape: StadiumBorder(side: BorderSide(color: Color(0xFFDADADA))),
          label: Text(thought.name),
          selected: _filters2.contains(thought.name),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters2.add(thought.name);
              } else {
                _filters2.removeWhere((String name) {
                  return name == thought.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  Widget feelingemotion() {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              color: Colors.blueAccent[200],
              height: 36,
            )),
      ),
      Text("Hissedilen Duygular"),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              color: Colors.blueAccent[200],
              height: 36,
            )),
      ),
    ]);
  }

  Widget thoughtfail() {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              color: Colors.blueAccent[200],
              height: 36,
            )),
      ),
      Text("Düşünce Hataları"),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              color: Colors.blueAccent[200],
              height: 36,
            )),
      ),
    ]);
  }

  Widget buttonWidget() {
    return OutlineButton(
      onPressed: () async {
        setState(() {
          rethought.situation = _controller.text;
          rethought.feelings = _filters;
          rethought.thoughts = _filters2;
          rethought..initialthought = _controller2.text;
          rethought.althinking = _controller3.text;
          rethought.time=DateTime.now();
        });

        // final uid2 = SharedManager.instance.getStringValue(SharedKeys.TOKEN);
        // print(uid2);
        final currentuser=await _firebaseAuth.currentUser();

        final colReturn = await db
            .collection("userData")
            .document(currentuser.uid)
            .collection("failthrought")
            .add(rethought.toJson());

        if (colReturn.documentID != null) {
           _ackAlert(context);
        }
       
      },
      highlightedBorderColor: Colors.lightBlueAccent,
      highlightColor: Colors.white,
      child: Text(
        "Kaydet",
        style: TextStyle(color: Colors.lightBlueAccent),
      ),
    );
  }

  Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        
        content: const Text('Düşünceniz Kaydedildi'),
        actions: <Widget>[
          FlatButton(
            child: Text('Tamam'),
            onPressed: () {
                 Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ThoughtRecord()))
            .then((_) => ThoughtRecord());
            },
          ),
        ],
      );
    },
  );
}

  Widget buttonWidget2() {
    return OutlineButton(
      onPressed: () {
        
        

        Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ThoughtRecord()))
            .then((_) => ThoughtRecord());
      },
      highlightedBorderColor: Colors.redAccent,
      highlightColor: Colors.white,
      child: Text(
        "Temizle",
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }
}

class Feeling {
  const Feeling(this.name);
  final String name;
}

class Thought {
  const Thought(this.name);
  final String name;
}

class ReThought {
  String situation;
  List<String> feelings;
  String initialthought;
  List<String> thoughts;
  String althinking;
  DateTime time;

  ReThought(this.situation, this.feelings, this.initialthought, this.thoughts,
      this.althinking,this.time);

  Map<String, dynamic> toJson() => {
        'situation': situation,
        'feelings': feelings,
        'initialthought': initialthought,
        'thoughts': thoughts,
        'althinking': althinking,
        'time':time
      };
}

import 'package:flutter/material.dart';

class ThoughtRecord extends StatefulWidget {
  @override
  _ThoughtRecordState createState() => _ThoughtRecordState();
}

// Düzeltme yapılıcak düşünce hataları ve hissedilen duygular arasında tabloya karar vermek gerekiyor.

class _ThoughtRecordState extends State<ThoughtRecord> {
  GlobalKey<ScaffoldState> _key;
  List<Feeling> _feelings;
  bool _isSelected;
  List<String> _filters;
  List<String> _filters2;

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
    _key = GlobalKey<ScaffoldState>();
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
      key: _key,
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
        textInputAction: TextInputAction.done,
        maxLines: 4,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            labelText: "Durum",
            hintText: "Ne oldu? Nerede? Ne zaman? Kiminle? Nasıl?",
            border: OutlineInputBorder()),
        onChanged: (text) {
          setState(() {});
        },
      ),
    );
  }

  Widget textContainer2() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextField(
        textInputAction: TextInputAction.done,
        maxLines: 4,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            labelText: "Otomatik Düşünceler",
            hintText: "Zihnimden neler geçti?",
            border: OutlineInputBorder()),
        onChanged: (text) {
          setState(() {});
        },
      ),
    );
  }

  Widget textContainer3() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextField(
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
      onPressed: () {
        debugPrint("Kaydet Butonu Tıkladın");
      },
      highlightedBorderColor: Colors.lightBlueAccent,
      highlightColor: Colors.white,
      child: Text(
        "Kaydet",
        style: TextStyle(color: Colors.lightBlueAccent),
      ),
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

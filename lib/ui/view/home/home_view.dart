import 'package:flutter/material.dart';
import 'package:tez_bdt/core/localdatamodel/option_model.dart';
import 'package:tez_bdt/ui/view/depressionTest/depression_start.dart';
import 'package:tez_bdt/ui/view/home/fire_home.dart';
import 'package:tez_bdt/ui/view/home/screen.dart';
import 'package:tez_bdt/ui/view/recordThought/thought_record.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int _selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[200],
        title:  Text('Hoşgeldiniz'),
        
        actions: <Widget>[
          
        ],
      ),
      body: ListView.builder(
        itemCount: options.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return SizedBox(height: 25.0);
          } else if (index == options.length + 1) {
            return SizedBox(height: 20.0);
          }
          return Container(
            
            alignment: Alignment.center,
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color:Colors.blue[200])
            ),
            child: ListTile(
              onLongPress: (){
                

              },
              leading: options[index - 1].icon,
              title: Text(
                options[index - 1].title,
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              subtitle: Text(
                options[index - 1].subtitle,
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              selected: true,
              onTap: () {
                if(index==1){
                   Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => QuestionStart()));}
                  else if(index==2){
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ThoughtRecord()));
                  }
                  else if(index==3){
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FireHomeView()));
                  }
                  else if(index==4){
                    print("Grafiksel takip Push");
                  }
                   else{
                    print("Anksiyete egzersizleri Push");
                  }

                },
            ),
          );
        },
      ),
      
    );
  }
  
}

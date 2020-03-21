import 'package:flutter/material.dart';

import '../../../core/model/student.dart';
import '../../../core/model/user.dart';
import '../../../core/services/firebase_services.dart';

class FireHomeView extends StatefulWidget {
  @override
  _FireHomeViewState createState() => _FireHomeViewState();
}

class _FireHomeViewState extends State<FireHomeView> {
  
  FirebaseService service;
    @override
    void initState() {
      super.initState();
      service = FirebaseService();
    }


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(),
      body: _studentsBuilder
    );
  }

  Widget get _userFutureBuilder => FutureBuilder<List<User>>(
        future: service.getUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                return _listUser(snapshot.data);
              } else {
                return _notFoundWidget;
              }

              break;
            default:
              return _waitingWidget;
          }
        },
      );

  Widget get _studentsBuilder => FutureBuilder<List<Student>>(
        future: service.getStudents(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                return _listStudent(snapshot.data);
              } else {
                return _notFoundWidget;
              }

              break;
            default:
              return _waitingWidget;
          }
        },
      );

  Widget _listUser(List<User> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _userCard(list[index]);
      },
    );
  }

  Widget _listStudent(List<Student> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _studentCard(list[index]);
      },
    );
  }

  Widget get _notFoundWidget => Center(
        child: Text("Not Found"),
      );
  Widget get _waitingWidget => Center(child: CircularProgressIndicator());

  Widget _userCard(User user) {
  return Card(
    child: ListTile(
      title: Text(user.name),
    ),
  );
}

Widget _studentCard(Student student) {
  return Card(
    child: ListTile(
      title: Text(student.name),
      subtitle: Text(student.number.toString()),
    ),
  );
}
}



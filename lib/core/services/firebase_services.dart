import 'dart:convert';

import 'dart:io';

import 'package:tez_bdt/core/model/student.dart';
import 'package:tez_bdt/core/model/user.dart';
import 'package:tez_bdt/core/model/user/user_auth_error.dart';
import 'package:tez_bdt/core/model/user/user_request.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  static const String FIREBASE_URL = "https://hwafire-416a6.firebaseio.com/";

  static const String FIREBASE_AUT_URL ="https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAa1lfFRYR5eZ7CanyLLl47VDyG18YgEFI";

  Future postUser(UserRequest request) async {
    var jsonModel = json.encode(request.toJson());

    final response = await http.post(FIREBASE_AUT_URL, body: jsonModel);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;

        break;
      default:
        var errorJson=json.decode(response.body);
        var error=FirebaseAuthError.fromJson(errorJson);
        return error;
    }
  }

  Future<List<User>> getUsers() async {
    final response = await http.get("$FIREBASE_URL/users.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);
        final userList = jsonModel
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<User>();

        return userList;

        break;
      default:
        return Future.error(response.statusCode);
    }
  }

  Future<List<Student>> getStudents() async {
    final response = await http.get("$FIREBASE_URL/students.json");

    switch (response.statusCode) {
      case HttpStatus.ok:

        //Gelen data modelden key ile gelen body yapısını for ile dolaşarak bir student nesnesi oluşturup value ları attık daha sonra
        //keyiniayrı olarak set ettik daha sonra student nesne listemize attık
        final jsonModel = json.decode(response.body) as Map;
        final studentList = List<Student>();
        jsonModel.forEach((key, value) {
          Student student = Student.fromJson(value);
          student.key = key;
          studentList.add(student);
        });

        return studentList;

        break;
      default:
        return Future.error(response.statusCode);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tez_bdt/core/model/user/user_auth_error.dart';
import 'package:tez_bdt/core/model/user/user_request.dart';
import 'package:tez_bdt/core/services/firebase_services.dart';
import 'package:tez_bdt/core/services/google_signin.dart';
import 'package:tez_bdt/ui/view/home/home_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String username;
  String password;
  FirebaseService service = FirebaseService();
  GlobalKey<ScaffoldState> scaffolf = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolf,
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              _boxdecoration(),
              Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 90.0,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _titleDecoration(),
                          Padding(
                            padding: EdgeInsets.only(top: 42),
                            child: Column(children: <Widget>[
                              _mailBox(),
                              SizedBox(height: 20),
                              _passwordBox(),
                              SizedBox(height: 20),
                              _forgotPasswordButton(),
                              _loginBtn(),
                              _socialButtonRow()
                            ]),
                          )
                        ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _boxdecoration() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  Widget _titleDecoration() {
    return Text(
      'Sign In',
      style: TextStyle(
        color: Colors.blue[200],
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _mailBox() {
    return TextFormField(
      onChanged: (val) {
        setState(() {
          username = val;
        });
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.blue[200],
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[200], width: 0.5)),
          labelText: "Email",
          hintText: "Enter your Email",
          labelStyle: TextStyle(
            color: Colors.blue[200],
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
          focusColor: Colors.blue[200],
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
              borderRadius: BorderRadius.circular(8.0))),
    );
  }

  Widget _passwordBox() {
    return TextFormField(
      onChanged: (val) {
        setState(() {
          password = val;
        });
      },
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(
        color: Colors.blue[200],
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
      ),
      obscureText: true,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[200], width: 0.5)),
          labelText: "Password",
          hintText: "Enter your Password",
          labelStyle: TextStyle(
            color: Colors.blue[200],
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[200], width: 2.0),
              borderRadius: BorderRadius.circular(8.0))),
    );
  }

  Widget _forgotPasswordButton() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0, bottom: 0),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.blue[200],
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _loginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 22.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          var result = await service.postUser(UserRequest(
              email: username, password: password, returnSecureToken: true));
          if (result is FirebaseAuthError) {
            scaffolf.currentState.showSnackBar(
              SnackBar(content: Text(result.error.message)),
            );
          } else {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        },
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        color: Colors.blue[200],
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.2,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _socialButtonRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _socialButton(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _socialButton(
            ontTap1,
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialButton(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap
      ,
      child: Container(
        height: 42.0,
        width: 32.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  void ontTap1() {
    setState(() async {
      
        var data = await GoogleSignHelper.instance.signIn();
        if (data != null) {
          var userData = await GoogleSignHelper.instance.FirebaseSignIn();
          //print(userData.accessToken);
          //print(userData.idToken);
        }
    });
  }
}

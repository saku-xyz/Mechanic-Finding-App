import 'package:flutter/material.dart';
import 'package:mechanic_finding_app/main.dart';
import 'package:mechanic_finding_app/user_signup.dart';
import 'package:passwordfield/passwordfield.dart';

import 'auth_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Future<bool> onAuthRunning() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Please Wait'),
        actions: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you really want to exit the app?'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  Future<void> loginFunction(String email) async {
    Navigator.pop(context, true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  final formKey = new GlobalKey<FormState>();

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: formKey,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                        height: 210.0,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //Email input
                              TextFormField(
                                controller: _email,
                                decoration: new InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                  ),
                                ),
                                maxLines: 1,
                              ),
                              PasswordField(
                                controller: _password,
                                color: Colors.grey,
                                hasFloatingPlaceholder: true,
                                //pattern: r'.*[@$#.*].*',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                errorMessage:
                                    'must contain special character either . * @ # \$',
                              ),
                              Container(
                                width: double.infinity,
                                child: RaisedButton(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: deviceRatio + 18.0,
                                    ),
                                  ),
                                  disabledColor: Colors.grey,
                                  elevation: 2,
                                  textColor: Colors.white,
                                  color: Colors.blueAccent,
                                  onPressed: () async {
                                    onAuthRunning();
                                    if (formKey.currentState.validate()) {
                                      try {
                                        final form = formKey.currentState;
                                        form.save();
                                        final auth = AuthService();
                                        String uid = await auth
                                            .signInWithEmailAndPassword(
                                                _email.text, _password.text);
                                        print('logged ======= $uid');
                                        if (uid.length > 0 && uid != null) {
                                          loginFunction(_email.text.toString())
                                              .then((value) =>
                                                  loggedUserDetails(
                                                      _email.text.toString()));
                                        }
                                      } catch (e) {
                                        setState(() {
                                          _email.clear();
                                          _password.clear();
                                        });
                                        print('Error: $e');
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                    'Login Failed',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  content: Text(
                                                    'Invalid E-mail or Password, please try again',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                        child: Text('close'),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, true);
                                                        }),
                                                  ],
                                                ));
                                      }
                                    }
                                  },
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  splashColor: Colors.white,
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don't have an account?",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                                fontSize: 14.0,
                              ),
                            ),
                            FlatButton(
                                child: Text(
                                  'Register Now',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                    fontSize: 20.0,
                                  ),
                                ),
                                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

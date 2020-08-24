import 'package:flutter/material.dart';
import 'package:mechanic_finding_app/main.dart';
import 'package:mechanic_finding_app/user_data.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:responsive_container/responsive_container.dart';

import 'auth_service.dart';
import 'home_page.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _mobileNumber = new TextEditingController();
  final TextEditingController _address = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _matchPassword = new TextEditingController();

  final formKey = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldSignUpKey = GlobalKey();

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
        barrierDismissible: false
    );
  }

  signUpFunction() async {
    try {
      onAuthRunning();
      final form = formKey.currentState;
      form.save();
      final auth = AuthService();
      String uid = await auth.createUserWithEmailAndPassword(_email.text, _password.text);
      print('signed ======= $uid');
      if (uid.length > 0 && uid != null) {
        print('signup success');
        signUp();
        Navigator.pop(context, true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      Navigator.of(context).pop();
      print('Error: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'SignUp Failed',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Invalid E-mail or Password or user already exists, please try with different details',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('close'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldSignUpKey,
        body: Stack(
          children: <Widget>[
            Center(
              child: Form(
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    ResponsiveContainer(
                      heightPercent: 1.0,
                      widthPercent: 100.0,
                    ), // notch neglect

                    ResponsiveContainer(
                        padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        heightPercent: 5.0,
                        widthPercent: 100.0,
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                color: Colors.transparent,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 30.0,
                                  ),
                                  color: Colors.blueAccent,
                                  splashColor: Colors.blueAccent,
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  alignment: Alignment.center,
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                ),
                              ),
                            ],
                          ),
                        )),

                    Container(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Get Started',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              )),
                          Text('Please enter your correct information.',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                height: 1.5,
                              )),
                          Text('* Required',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                  height: 1.5,
                                  color: Colors.red)),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Name
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  paste: true,
                                  cut: true,
                                  selectAll: false),
                              validator: (value) {
                                String namePattern = r'^[A-Za-z ]{3,40}$';
                                RegExp regExpName = new RegExp(namePattern);

                                if (value.isEmpty) {
                                  return 'Name is Missing';
                                } else if (!regExpName.hasMatch(value)) {
                                  return 'Please enter a appropriate name';
                                }
                                return null;
                              },
                              controller: _name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(5.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.blueAccent)),
                                labelText: 'Name *',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.grey,
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ),

                          // Mobile Number
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  paste: true,
                                  cut: true,
                                  selectAll: false),
                              validator: (value) {
                                String numberPattern = r'^[0-9]{9}$';
                                RegExp regExpNumber = new RegExp(numberPattern);
                                if (value.isEmpty) {
                                  return 'Mobile Number is Missing';
                                } else if (!regExpNumber.hasMatch(value)) {
                                  return 'Please enter a valid mobile number';
                                }
                                return null;
                              },
                              controller: _mobileNumber,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(5.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 2, color:Colors.blueAccent)),
                                prefixText: '+94',
                                labelText: 'Mobile Number *',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.grey,
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ),

                          //number

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _email,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'E-Mail is Missing';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(5.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.blueAccent)),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.grey,
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ), //email

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _address,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Address is Missing';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.blueAccent)),
                                helperStyle: TextStyle(color: Colors.red),
                                labelText: 'Address',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.grey,
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: PasswordField(
                              controller: _password,
                              color: Colors.grey,
                              hasFloatingPlaceholder: true,
                              pattern: r'^[A-Za-z0-9_@.]{6,20}$',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                  BorderSide(width: 1, color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.blueAccent)),
                              errorMessage: 'minimum length is 6 charcters',
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _matchPassword,
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'empty field..!';
                                } else if (value != _password.text.toString()) {
                                  return 'password do not match';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(5.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.blueAccent)),
                                labelText: 'Confirm password',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.grey,
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            child: RaisedButton(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                'REGISTER',
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
                                if (formKey.currentState.validate()) {
                                  //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing...'),));
                                  signUpData[0] = _name.text;
                                  signUpData[1] = _mobileNumber.text;
                                  signUpData[2] = _email.text;
                                  signUpData[3] = _address.text;
                                  signUpData[4] = _password.text;

                                  signUpFunction();
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              splashColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}

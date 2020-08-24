import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_finding_app/auth_service.dart';
import 'dart:async';
import 'home_page.dart';
import 'login_page.dart';

double deviceRatio;

String userEmail;
String userRole;
String userName;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() {
    print('Completed');
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<String> loggedUserDetails(String email) async{
  FirebaseFirestore dbreference = FirebaseFirestore.instance;
  await dbreference.collection('user').doc(email).collection('user_details').doc('details').get().then((value){
    userName = value.data()['name'];
  });
  return 'success';
}

class _MyHomePageState extends State<MyHomePage> {

  Future<void> currentLoggedUser() async {
    final auth = AuthService();
    try{
      var currentUser = await auth.getCurrentUser();
      if(currentUser == null){
        print('no user exist');
        Timer(Duration(seconds: 2), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())));
      }else{
        userEmail = currentUser.email.toString();
        loggedUserDetails(userEmail).then((value) => Timer(Duration(seconds: 2), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()))));
      }
    }catch (e){
      print('Error: $e');
    }
  }

  void initState(){
    super.initState();
    currentLoggedUser();
  }


  @override
  Widget build(BuildContext context) {

    deviceRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

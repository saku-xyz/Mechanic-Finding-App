import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_finding_app/login_page.dart';
import 'package:mechanic_finding_app/main.dart';

import 'auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> userLogOut() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                accountName: Text(userName.toString()),
                accountEmail: Text(userEmail.toString()),
              ),
              ListTile(
                onTap: () async {
                  try {
                    final auth = AuthService();
                    await auth.signOut();
                    userLogOut();
                  } catch (e) {
                    print('Error: $e');
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Logout Failed',
                            textAlign: TextAlign.center,
                          ),
                          content: Text(
                            'Something went wrong..!, please try again',
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            FlatButton(
                                child: Text('close'),
                                onPressed: () {
                                  Navigator.pop(context, false);
                                }),
                          ],
                        ));
                  }
                },
                title: Text(
                  'Log Out',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: (deviceRatio * 10) / 4 + 10.5,
                    color: Colors.grey[800],
                  ),
                ),
                trailing: Icon(
                  Icons.exit_to_app,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      body: Stack(
        children: [

        ],
      ),
    );
  }
}

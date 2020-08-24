import 'package:cloud_firestore/cloud_firestore.dart';

var signUpData = new List(5);

Future<String> signUp() async{
  FirebaseFirestore dbreference = FirebaseFirestore.instance;
  void createUser() async{
    await dbreference.collection('user').doc(signUpData[2]).collection('user_details').doc('details').set({
      'name':signUpData[0].toString(),
      'mobile':signUpData[1].toString(),
      'email':signUpData[2].toString(),
      'delivery_address':signUpData[3].toString(),
    });
    await dbreference.collection('user').doc(signUpData[2]).set({
      //'pswd':signUpData[4].toString(),
      'role':'user'
    });
  }
  createUser();
  return 'successful';
}
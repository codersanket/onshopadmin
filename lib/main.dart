import 'package:admin/addCategory.dart';
import 'package:admin/subCategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("Hello");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return homePage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: CircularProgressIndicator(),
        );
      },
    );
  }
}

class homePage extends StatelessWidget {
  List main = [
    "Add Category",
    "Add Sub Category",
    "Add Sub Sub Category",
    "Add Items",
    "See Orders"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "Home".text.make(),
          actions: [
            IconButton(
              onPressed: () => FirebaseAuth.instance.signInAnonymously(),
              icon: Icon(
                Icons.people,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: VStack([
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => addCategory())),
            child: listTile("Add Category"),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SubCategoryScreen())),
            child: listTile("Add SubCategory"),
          ),
          GestureDetector(
            child: listTile("Add Sub-Sub Category"),
          ),
          GestureDetector(
            child: listTile("Add Items"),
          ),
          GestureDetector(
            child: listTile("See Orders"),
          ),
        ]));
  }

  Widget listTile(String title) {
    return Card(
      child: ListTile(
        title: "${title}".text.make(),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

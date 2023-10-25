import 'package:flutter/material.dart';
import 'package:task_one/screens/regPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final CollectionReference studentdetailes = FirebaseFirestore.instance
      .collection('studentdetailes');
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade200,
        elevation: 0,
        title: Text(
          'Student Detailes',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
          stream: studentdetailes.snapshots(),
          builder: (context,AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot student = snapshot.data?.docs[index];
                    return Text(student['First Name']);
                  });
            }
            return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Center(
                child: Text("Nothing to show"),
              ),
            );
          }
        // child: Column(
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.all(16.0),
        //       child: TextField(
        //         controller: _searchController,
        //         decoration: InputDecoration(
        //           hintText: 'Search Student',
        //           prefixIcon: Icon(Icons.search),
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(12.0),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Center(
        //       child: Text(
        //         'Welcome to the First Page!',
        //         style: TextStyle(fontSize: 24),
        //       ),
        //     ),
        //   ],
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RegPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

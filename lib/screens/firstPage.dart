import 'package:flutter/material.dart';
import 'package:task_one/screens/profilePage.dart';
import 'package:task_one/screens/regPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final CollectionReference studentdetailes =
      FirebaseFirestore.instance.collection('studentdetailes');
  TextEditingController _searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  List searchResult = [];

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Student',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: studentdetailes.snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot student =
                                snapshot.data?.docs[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfilePage(
                                              student: student,
                                            )));
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name: ${student['First Name']} ${student['Last Name']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Email: ${student['Email Address']}",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        PopupMenuButton(
                                          icon: Icon(Icons.more_vert),
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: Text("Delete"),
                                              onTap: () {
                                                delete(student.id);
                                              },
                                            ),
                                            PopupMenuItem(
                                              child: Text("Edit"),
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/update',
                                                    arguments: {
                                                      'First Name':
                                                          student['First Name'],
                                                      'Last Name':
                                                          student['Last Name'],
                                                      'Email Address': student[
                                                          'Email Address'],
                                                      'Gender':
                                                          student['Gender'],
                                                      'Date of Birth': student[
                                                          'Date of Birth'],
                                                      'Age': student['Age'],
                                                      'Nationality': student[
                                                          'Nationality'],
                                                      'Address':
                                                          student['Address'],
                                                      'Parent Name': student[
                                                          'Parent Name'],
                                                      'Guardian Name': student[
                                                          'Guardian Name'],
                                                      'Place': student['Place'],
                                                      'Phone Number': student[
                                                              'Phone Number']
                                                          .toString(),
                                                      'id': student.id,
                                                    });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Phone: ${student['Phone Number']}",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Container(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: Center(
                          child: Text("Nothing to show"),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
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

  void delete(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Confirmation'),
        content: Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              studentdetailes.doc(id).delete();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Deleted.'),
                duration: Duration(seconds: 1),
              ));
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

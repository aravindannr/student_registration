import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final student;

  const ProfilePage({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile Page',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Card(
                        elevation: 8,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("Assets/images/profile.png"),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                      Text(
                        '${student['First Name']} ${student['Last Name']}',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Roboto'
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email Address'),
                  subtitle: Text(student['Email Address']),
                ),
                Divider(color: Colors.grey),
                ListTile(
                  leading: Icon(Icons.cake),
                  title: Text('Date of Birth'),
                  subtitle: Text(student['Date of Birth']),
                ),
                Divider(color: Colors.grey),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone Number'),
                  subtitle: Text(student['Phone Number']),
                ),
                Divider(color: Colors.grey),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Address'),
                  subtitle: Text(student['Address']),
                ),
                Divider(color: Colors.grey),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Parent Name'),
                  subtitle: Text(student['Parent Name']),
                ),
                Divider(color: Colors.grey),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Guardian Name'),
                  subtitle: Text(student['Guardian Name']),
                ),
                Divider(color: Colors.grey),
                ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text('Place'),
                  subtitle: Text(student['Place']),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(Icons.flag),
                  title: Text('Nationality'),
                  subtitle: Text(student['Nationality']),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

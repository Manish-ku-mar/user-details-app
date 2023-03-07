import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screen2.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  List<String> locations = <String>[
    'Facebook',
    'Instagram',
    'Organic',
    'Friend',
    'Google'
  ];
  String dropdownIntialvalue = 'Facebook';

  final FirebaseAuth _auth = FirebaseAuth.instance;

//add user
  Future createNewUser() async {
    final  data = {
      'email': _emailContoller.text.trim(),
      'name': _nameController.text.trim(),
      'loaction': await dropdownIntialvalue,
    };

    await FirebaseFirestore.instance
        .collection('UserDetails')
        .doc()
        .set(data, SetOptions(merge: true))
        .onError((error, _) => print(error.toString()));

    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserDetails()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _emailContoller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 30),
                      // DropdownButton<String>(
                      //   value: dropdownIntialvalue,
                      //     items:locations.map<DropdownMenuItem<String>>((String val) {
                      //      return DropdownMenuItem<String>(
                      //        value: val,
                      //          child: Text(val));
                      //     }
                      //     ).toList(),
                      //     onChanged: (String? value) {
                      //       // This is called when the user selects an item.
                      //       setState(() {
                      //         dropdownIntialvalue = value!;
                      //       });
                      //     }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width:MediaQuery.of(context).size.width/3,
                            child: Text(
                              "Where are you coming from?",
                              style: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                          Container(
                            child: DropdownButton<String>(
                              value: dropdownIntialvalue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 32,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(
                                height: 0.5,
                                color: Colors.black,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownIntialvalue = value!;
                                  print(dropdownIntialvalue);
                                });
                              },
                              items: locations.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            child: Text('Sign Up'),
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                createNewUser();
                              }
                            },
                            color: Colors.white,
                          ),
                          MaterialButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //services

// registration with email and password

  //create user
  // void createUser() async {
  //   dynamic result = await createNewUser(
  //       _nameController.text, _emailContoller.text, _locationController.text);
  //   if (result == null) {
  //     print('Email is not valid');
  //   } else {
  //     print(result.toString());
  //     _nameController.clear();
  //     _locationController.clear();
  //     _emailContoller.clear();
  //     Navigator.pop(context);
  //   }
  // }
}

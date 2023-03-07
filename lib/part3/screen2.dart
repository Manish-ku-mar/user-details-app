import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/user_model.dart';


class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  List<User> userDetails = [];
  List<User> dummyList = [];
  List<String> _filters = [
    'Choose a location',
    'Facebook',
    'Instagram',
    'Organic',
    'Friend',
    'Google'
  ];
  String _selectedFilter = 'Choose a location';
  final searchController = TextEditingController();

  getData() async {
    var records =
        await FirebaseFirestore.instance.collection("UserDetails").get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var finalrecords = records.docs
        .map((user) => User(
            email: user['email'],
            loaction: user['loaction'],
            name: user['name'],
            id: user.id))
        .toList();
    setState(() {
      userDetails = finalrecords;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('User Details')),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Center(
                child: Text(
              "Already logged in Users",
              style: TextStyle(fontSize: 20),
            )),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: userDetails.length,
                  itemBuilder: (context, ind) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: ListTile(
                          title: Center(
                              child: Text(
                                  'User ${ind + 1}.  ${userDetails[ind].name}')),
                          hoverColor: Colors.grey,
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 20,),
            Divider(height: 2, thickness: 2),
            Center(
              child: Container(
                // width: MediaQuery.of(context).size.width/10*9,
                child: DropdownButton<String>(
                  hint: Text("where are coming from"),
                  value: _selectedFilter,
                  elevation: 32,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 0.5,
                    color: Colors.black,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      _selectedFilter = value ?? "";
                      print(_selectedFilter);
                      searchUser(_selectedFilter);
                    });
                  },
                  items: _filters.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(child: Text("Or",style: TextStyle(fontSize: 16,color: Colors.grey.shade600),),),
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search by name,email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Colors.grey))),
                onChanged: searchUser,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: dummyList.length,
                  itemBuilder: (context, ind) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                        ),
                        child: ListTile(
                          title: Center(
                              child: Text(
                                  'User ${ind + 1}.  ${dummyList[ind].name}')),
                          subtitle: Text(
                              '${dummyList[ind].email} ${dummyList[ind].loaction}'),
                          hoverColor: Colors.grey,
                        ),
                      ),
                    );
                  }),
            ),
          ])),
    );
  }

  void searchUser(String query)  {
    final searchedList = userDetails.where((user) {
      final userName = user.name.toLowerCase();
      final userEmail = user.email.toLowerCase();
      final userLocation = user.loaction.toLowerCase();
      final input = query.toLowerCase();
      return userName.contains(input) || userEmail.contains(input)||userLocation==input;
    }).toList();
    setState(() {
      dummyList = searchedList;
    });
  }
}

import 'package:flutter/material.dart';


import '../controller/UserController.dart';
import '../model/User.dart';

class

UsersPage

    extends

    StatefulWidget

{
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class

_UsersPageState

    extends

    State<UsersPage> {
  List<User> users  = [];

  Future<void> fetchUsers() async {
    try {
      final serverUsers = await UserController.fetchUsers();
      setState(() {
        users = serverUsers;
      });
    } catch (e) {
      // Handle the error
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> refreshUsers() async {
    try {
      final serverUsers = await UserController.fetchUsers();
      setState(() {
        users = serverUsers;
      });
    } catch (e) {
      // Handle the error
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshUsers, // Function to call when pulling down to refresh.
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return buildClickableCard(context, users[index]);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the add AV hall page
          Navigator.pushNamed(context, '/registerteacher');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildClickableCard(BuildContext context, User user) {
    return InkWell(
      onTap: () {
        // Show a dialog to view user information
      },
      child: SizedBox(
        height: 100,
        width: 350,
        child: Card(
          elevation: 6,
          child: Center(
            child: Text(
              user.firstname+" "+user.lastname,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'dart:convert';

import '../contant/Constants.dart';
import '../model/User.dart';
import 'package:http/http.dart' as http;
class UserController{

  static Future<bool> registerTeacher(User user) async {
    final url = Constants.getUri('user'); // Replace with your API endpoint

    // Define the request body as a map

    final response = await http.post(
      url,
      body: jsonEncode(user),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Constants.getUri('user'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<User> users = data.map((item) {
        final int id = item['id'];
        final String firstname = item['firstname'];
        final String lastname = item['lastname'];
        final String email = item['email'];
        final String phone = item['phone'];

        return User(
          id: id,
          firstname: firstname,
          lastname: lastname,
          email: email,
          phone: phone,
        );
      }).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }



}
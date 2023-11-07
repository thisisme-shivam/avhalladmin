
import 'package:flutter/material.dart';

import '../controller/UserController.dart';
import '../dialogs/DialogHelper.dart';
import '../model/User.dart';

class RegisterTeacher extends StatefulWidget {
  const RegisterTeacher({super.key});

  @override
  State<RegisterTeacher> createState() => _RegisterTeacherState();
}

class _RegisterTeacherState extends State<RegisterTeacher> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? validateEmail(String value) {
    // Email validation regex
    String emailPattern = r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b';
    RegExp regExp = RegExp(emailPattern, caseSensitive: false);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validateName(String value) {
    String namePattern = r'^[A-Za-z ]+$'; // Pattern to accept alphabetic characters and spaces
    RegExp regExp = RegExp(namePattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid name (letters and spaces only)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Teacher')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return validateName(value);
              },
            ),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return validateName(value);
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email ID'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => validateEmail(value!),
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, continue with processing the input values
                  final firstName = firstNameController.text;
                  final lastName = lastNameController.text;
                  final email = emailController.text;
                  final phoneNumber = phoneNumberController.text;

                  User user = User(id: 0, firstname: firstName, lastname: lastName, email: email,  phone: phoneNumber);

                  DialogHelper.showLoadingDialog(
                    context,
                  );
                  bool isSaved = await UserController.registerTeacher(user);
                  if(isSaved){
                    DialogHelper.hideLoadingDialog(context);
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Register and Send Credentials'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}

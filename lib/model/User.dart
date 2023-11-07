class User {
  int _id;
  String _firstname;
  String _lastname;
  String _email;
  String _phone;

  User.empty() :
    _id = 0,
    _firstname = '',
    _lastname = '',
    _email = '',
    _phone = '';

  User({
    required int id,
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
  })   : _id = id,
        _firstname = firstname,
        _lastname = lastname,
        _email = email,
        _phone = phone;

  // Getters
  int get id => _id;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get email => _email;
  String get phone => _phone;

  // Setters
  set id(int value) {
    _id = value;
  }

  set firstname(String value) {
    _firstname = value;
  }

  set lastname(String value) {
    _lastname = value;
  }

  set email(String value) {
    _email = value;
  }



  set phone(String value) {
    _phone = value;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'firstname': _firstname,
      'lastname': _lastname,
      'email': _email,
      'phone': _phone,
    };
  }
}

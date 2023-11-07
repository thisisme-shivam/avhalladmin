class AVHall {
  int _id; // Non-nullable field for id
  String _name; // Non-nullable field for name

  int get id => _id; // Getter for id

  set id(int id) {
    _id = id; // Setter for id
  }

  String get name => _name; // Getter for name

  set name(String name) {
    _name = name; // Setter for name
  }

  AVHall.empty()
      : _id = 0,
        _name = '';
  AVHall({required int id, required String name})
      : _id = id,
        _name = name;

  factory AVHall.fromJson(Map<String, dynamic> json) {
    return AVHall(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
    };
  }
}

import 'package:flutter/material.dart';

class Booking {
  int _id;
  String _hallName;
  TimeOfDay _startTime;
  TimeOfDay _endTime;
  String _date;

  Booking({
    required int id,
    required String hallName,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required String date,
  })  :_id = id,
        _hallName = hallName,
        _startTime = startTime,
        _endTime = endTime,
        _date = date;

  String get hallName => _hallName;

  set hallName(String hallName) {
    _hallName = hallName;
  }

  TimeOfDay get startTime => _startTime;

  set startTime(TimeOfDay startTime) {
    _startTime = startTime;
  }

  TimeOfDay get endTime => _endTime;

  set endTime(TimeOfDay endTime) {
    _endTime = endTime;
  }

  String get date => _date;

  set date(String date) {
    _date = date;
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      hallName: json['hallName'],
      startTime: parseSQLTime(json['startTime']),
      endTime: parseSQLTime(json['endTime']),
      date: json['date'].toString(),
    );
  }



  static TimeOfDay parseSQLTime(String sqlTime) {
    final parts = sqlTime.split(':');
    if (parts.length == 3) {
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    }
    return TimeOfDay(hour: 0, minute: 0); // Default value if parsing fails
  }
}

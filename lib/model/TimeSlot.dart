import 'package:flutter/material.dart';

class TimeSlot {
  int? _id;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  TimeOfDay? _lunchTime;
  String? _year;

  int get id => _id!;

  set id(int id) {
    _id = id;
  }

  TimeOfDay? get startTime => _startTime;

  set startTime(TimeOfDay? startTime) {
    _startTime = startTime;
  }

  TimeOfDay? get endTime => _endTime;

  set endTime(TimeOfDay? endTime) {
    _endTime = endTime;
  }

  TimeOfDay? get lunchTime => _lunchTime;

  set lunchTime(TimeOfDay? lunchTime) {
    _lunchTime = lunchTime;
  }

  String? get year => _year;

  set year(String? year) {
    _year = year;
  }

  TimeSlot({
    required int id,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    TimeOfDay? lunchTime,
    String? year,
  })  : _id = id,
        _startTime = startTime,
        _endTime = endTime,
        _lunchTime = lunchTime,
        _year = year;
}

TimeSlot timeSlotFromJson(Map<String, dynamic> json) {
  return TimeSlot(
      id: json['id'],
      startTime: parseSQLTime(json['startTime']),
      endTime: parseSQLTime(json['endTime']),
      lunchTime: parseSQLTime(json['lunchTime']),
      year: json['year']
  );
}

TimeOfDay parseSQLTime(String sqlTime) {
  final parts = sqlTime.split(':');
  if (parts.length == 3) {
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
  }
  return TimeOfDay(hour: 0, minute: 0); // Default value if parsing fails
}

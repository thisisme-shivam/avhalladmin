
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Utility.dart';
import '../contant/Constants.dart';
import '../model/TimeSlot.dart';
class TimeController{
  static Future<bool> updateTimings(TimeSlot timing) async {
    final url = Constants.getUri('timeslot');

    Map<String,dynamic> timingMap={
      "startTime":timeOfDayToSqlTime(timing.startTime!),
      "endTime":timeOfDayToSqlTime(timing.endTime!),
      "lunchTime":timeOfDayToSqlTime(timing.lunchTime!),
      "year": timing.year
    };
    final response = await http.post(
      url,
      body: jsonEncode(timingMap),
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


  static Future<List<TimeSlot>> fetchTimings() async {
    final response = await http.get(Constants.getUri('timeslot'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<TimeSlot> timeSlots = data.map((item) {
        final int id = item['id'];
        final TimeOfDay startTime = parseSQLTime(item['startTime']);
        final TimeOfDay endTime = parseSQLTime(item['endTime']);
        final TimeOfDay lunchTime = parseSQLTime(item['lunchTime']);
        final String year = item['year'];
        print(startTime.toString() +" " + endTime.toString() + " "+ lunchTime.toString());
        return TimeSlot(id: id, startTime: startTime, endTime: endTime, lunchTime: lunchTime, year: year);
      }).toList();
      return timeSlots;
    } else {
      throw Exception('Failed to load time slots');
    }
  }

 static TimeOfDay parseSQLTime(String sqlTime) {
    final parts = sqlTime.split(':');
    if (parts.length == 3) {
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute,);
    }
    return TimeOfDay(hour: 0, minute: 0); // Default value if parsing fails
  }

  
}

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../contant/Constants.dart';
import '../model/AVHall.dart';

class AVHallController {
  static Future<List<AVHall>> fetchAVHalls()  async {
    final response = await http.get(Constants.getUri('avhalls'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<AVHall> halls = data.map((item) {
        final int id = item['id'];
        final String name = item['name'];
        return AVHall(id: id, name: name);
      }).toList();
    return halls;
    } else {
      throw Exception('Failed to load AV halls');
    }
  }

  static Future<bool> saveAVHall(String avHallName) async {
    final url = Constants.getUri('avhalls'); // Replace with your API endpoint

    // Define the request body as a map
    AVHall avHall =  AVHall(id: 0,name: avHallName);

    final response = await http.post(
      url,
      body: jsonEncode(avHall),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('AV hall saved successfully');
      return true;
    } else {
      print('Failed to save AV hall: ${response.statusCode}');
      print(response.body);
      return false;
    }
  }

}

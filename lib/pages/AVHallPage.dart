
import 'package:flutter/material.dart';

import '../controller/AVHallController.dart';
import '../controller/UserController.dart';
import '../model/AVHall.dart';

class AVHallPage extends StatefulWidget {
  const AVHallPage({Key? key}) : super(key: key);

  @override
  State<AVHallPage> createState() => _AVHallPageState();
}

class _AVHallPageState extends State<AVHallPage> {
  List<AVHall> avHalls = [];

  @override
  void initState() {
    super.initState();
    fetchAVHalls(); // Fetch initial data when the widget is created.
  }

  Future<void> fetchAVHalls() async {
    try {
      final serverAVHalls = await AVHallController.fetchAVHalls();
      setState(() {
        avHalls = serverAVHalls;
      });
    } catch (e) {
      // Handle the error
      print('Error: $e');
    }
  }

  Future<void> refreshAVHalls() async {
    try {
      final serverAVHalls = await AVHallController.fetchAVHalls(); // Always load the first page when refreshing.
      setState(() {
        avHalls = serverAVHalls;
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
        onRefresh: refreshAVHalls,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: avHalls.length,
            itemBuilder: (context, index) {
              return buildClickableCard(context, avHalls[index]);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the add AV hall page
          Navigator.pushNamed(context, '/addhall');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildClickableCard(BuildContext context, AVHall hall) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/bookhall', arguments: hall);
        print('Clicked on ${hall.name}');
      },
      child: SizedBox(
        height: 100,
        width: 350,
        child: Card(
          elevation: 6,
          child: Center(
            child: Text(
              hall.name,
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


import 'package:flutter/material.dart';

import '../controller/TImeController.dart';
import '../model/TimeSlot.dart';
class TimeSelectionCard extends StatefulWidget {
  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final TimeOfDay lunchTime;
  final ValueChanged<TimeOfDay> onStartTimeChanged;
  final ValueChanged<TimeOfDay> onEndTimeChanged;
  final ValueChanged<TimeOfDay> onLunchTimeChanged;

  TimeSelectionCard({
    Key? key,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.lunchTime,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    required this.onLunchTimeChanged,
  }) : super(key: key);

  @override
  State<TimeSelectionCard> createState() => _TimeSelectionCardState();
}

class _TimeSelectionCardState extends State<TimeSelectionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: const TextStyle(fontSize: 18.0)),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Text('Start time:', style: const TextStyle(fontSize: 16.0)),
              const SizedBox(width: 8.0),
              TextButton(
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: widget.startTime,
                  ).then((time) {
                    if (time != null) {
                      widget.onStartTimeChanged(time);
                    }
                  });
                },
                child: Text(widget.startTime.format(context)),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Text('End time:', style: const TextStyle(fontSize: 16.0)),
              const SizedBox(width: 8.0),
              TextButton(
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: widget.endTime,
                  ).then((time) {
                    if (time != null) {
                      widget.onEndTimeChanged(time);
                    }
                  });
                },
                child: Text(widget.endTime.format(context)),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Text('Lunch time:', style: const TextStyle(fontSize: 16.0)),
              const SizedBox(width: 8.0),
              TextButton(
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: widget.lunchTime,
                  ).then((time) {
                    if (time != null) {
                      widget.onLunchTimeChanged(time);
                    }
                  });
                },
                child: Text(widget.lunchTime.format(context)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SlotsPage extends StatefulWidget {
  const SlotsPage({Key? key}) : super(key: key);

  @override
  State<SlotsPage> createState() => _HomePageState();
}

class _HomePageState extends State<SlotsPage> {
  TimeOfDay otherYearStartTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay otherYearEndTime = TimeOfDay(hour: 17, minute: 0);
  TimeOfDay otherYearLunchTime = TimeOfDay(hour: 12, minute: 0);

  TimeOfDay firstYearStartTime = TimeOfDay(hour: 10, minute: 0);
  TimeOfDay firstYearEndTime = TimeOfDay(hour: 18, minute: 0);
  TimeOfDay firstYearLunchTime = TimeOfDay(hour: 13, minute: 0);
  @override
  void initState() {
    super.initState();

    // Initialize the timing values from the backend using TimeController.
    updateTimings();
  }
  Future<void> updateTimings() async {
    final List<TimeSlot> timeslots = await TimeController.fetchTimings();
    for(TimeSlot slot in timeslots){
      if(slot.year=="FIRSTYEAR"){
        setState(() {
          firstYearEndTime = slot.endTime!;
          firstYearLunchTime = slot.lunchTime!;
          firstYearStartTime = slot.startTime!;
        });
      }else{
        setState(() {
          otherYearEndTime = slot.endTime!;
          otherYearLunchTime = slot.lunchTime!;
          otherYearStartTime = slot.startTime!;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TimeSelectionCard(
            title: 'Other Year',
            startTime: otherYearStartTime,
            endTime: otherYearEndTime,
            lunchTime: otherYearLunchTime,
            onStartTimeChanged: (newTime) {
              setState(() {
                otherYearStartTime = newTime;
              });
            },
            onEndTimeChanged: (newTime) {
              setState(() {
                otherYearEndTime = newTime;
              });
            },
            onLunchTimeChanged: (newTime) {
              setState(() {
                otherYearLunchTime = newTime;
              });
            },
          ),
          const SizedBox(height: 16.0),
          TimeSelectionCard(
            title: 'First Year',
            startTime: firstYearStartTime,
            endTime: firstYearEndTime,
            lunchTime: firstYearLunchTime,
            onStartTimeChanged: (newTime) {
              setState(() {
                firstYearStartTime = newTime;
              });
            },
            onEndTimeChanged: (newTime) {
              setState(() {
                firstYearEndTime = newTime;
              });
            },
            onLunchTimeChanged: (newTime) {
              setState(() {
                firstYearLunchTime = newTime;
              });
            },
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Get the timing for both cards
              final otherYearTiming = TimeSlot(
                id: 0,
                startTime: otherYearStartTime,
                endTime: otherYearEndTime,
                lunchTime: otherYearLunchTime,
                year: 'OTHERYEAR',
              );

              final firstYearTiming = TimeSlot(
                id: 0,
                startTime: firstYearStartTime,
                endTime: firstYearEndTime,
                lunchTime: firstYearLunchTime,
                year: 'FIRSTYEAR',
              );

              TimeController.updateTimings(firstYearTiming);
              TimeController.updateTimings(otherYearTiming);

              // Do something with the timing
            },
            child: const Text('Update Timing'),
          ),
        ],
      ),
    );
  }


}


import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import '../controller/BookingController.dart';
import '../model/Booking.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'dart:math';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DateTime? selectedDate;
  List<Booking> bookings = []; // List to store the bookings

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    fetchBookings(); // Fetch bookings when the page loads
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(2021),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      fetchBookings(); // Fetch updated bookings when the date is changed
    }
  }

  Future<void> fetchBookings() async {
    try {
      final List<Booking> fetchedBookings =
      await BookingController.fetchBookingsByDate(selectedDate!);
      setState(() {
        bookings = fetchedBookings;
      });
    } catch (e) {
      // Handle error
      print('Error fetching bookings: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Date Selector
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text(
                DateFormat('MMMM dd, yyyy').format(selectedDate!),
              ),
            ),
          ),

          // Booking List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await fetchBookings(); // Fetch bookings when refreshing
              },
              child: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final DateFormat timeFormat = DateFormat.Hm(); // Customize the time format (e.g., "HH:mm")

                  // Assuming that bookings[index].startTime and bookings[index].endTime are TimeOfDay objects
                  final TimeOfDay startTime = bookings[index].startTime;
                  final TimeOfDay endTime = bookings[index].endTime;

                  // Format TimeOfDay as a string
                  final String formattedStartTime = timeFormat.format(
                      DateTime(0, 1, 1, startTime.hour, startTime.minute));
                  final String formattedEndTime =
                  timeFormat.format(DateTime(0, 1, 1, endTime.hour, endTime.minute));

                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hall Name: ${bookings[index].hallName}'),
                          Text('Start Time: $formattedStartTime'),
                          Text('End Time: $formattedEndTime'),
                        ],
                      ),

                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          requestStoragePermission();
          generatePDFReport();
        },
        child: Icon(Icons.description),
      ),
    );
  }
  Future<void> generatePDFReport() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (context) {
        return pw.Column(
          children: [
            pw.Text('Booking Report', style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 10),
            pw.Text('Date: ${DateFormat('MMMM dd, yyyy').format(selectedDate!)}'),
            pw.SizedBox(height: 10),
            for (final booking in bookings)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Hall Name: ${booking.hallName}'),
                  pw.Text('Start Time: ${booking.startTime}'),
                  pw.Text('End Time: ${booking.endTime}'),
                  pw.Divider(),
                ],
              ),
          ],
        );
      },
    ));

    final bytes = await pdf.save();
    try {
      // Request external storage directory
      final externalDir = await getExternalStorageDirectory();

      if (externalDir != null) {
        final String externalPath = externalDir.path;
        final String fileName = getRandomString(8)+".pdf"; // Replace with your desired file name.

        // Construct the full file path in the external storage directory
        final String filePath = '$externalPath/$fileName';

        // Write the PDF content to the file
        final file = File(filePath);
        await file.writeAsBytes(bytes);
        final openFile = await OpenFile.open(filePath);

        print('File saved to: $filePath');
      } else {
        print('External storage directory is null.');
      }
    } catch (e) {
      print('Error saving file: $e');
    }


  }
  bool permissionGranted = false;
  Future<void> requestStoragePermission() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    if(Platform.isAndroid) {
      await Permission.manageExternalStorage.request();
      if (android.version.sdkInt < 33) {
        if (await Permission.storage
            .request()
            .isGranted) {
          setState(() {
            permissionGranted = true;
          });
        } else if (await Permission.storage
            .request()
            .isPermanentlyDenied) {
          await openAppSettings();
        } else if (await Permission.audio
            .request()
            .isDenied) {
          setState(() {
            permissionGranted = false;
          });
        }
      }
    }
  }

  String getRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }
}

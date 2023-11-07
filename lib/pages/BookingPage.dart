import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int selectedValue = -1; // Selected radio value
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Hall'),

      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 350,
              height: 100,
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Select Year',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio<int>(
                              value: 1,
                              groupValue: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value!;
                                });
                              },
                            ),
                            const Text(
                              'First Year',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<int>(
                              value: 2,
                              groupValue: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value!;
                                });
                              },
                            ),
                            const Text(
                              'Other Year',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 350,
              height: 80,
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Row(
                        children: [
                          Text(
                            'Select Date',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            DateTime? datepicked = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2023, 1,
                                  1), // Set an initial date on or before lastDate
                              firstDate: DateTime(2021),
                              lastDate:
                              DateTime(2026), // Set a future date as lastDate
                            );

                            if (datepicked != null) {
                              // Do something with the selected date
                              setState(() {
                                selectedDate = datepicked;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(

                          ),
                          child: Text(
                            selectedDate != null
                                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                : 'Select Date',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                if (selectedValue == 1)
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(
                              left: 120,
                              right: 120,
                            )),
                        child: Text("9:35 to 10:35"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(
                              left: 120,
                              right: 120,
                            )),
                        child: Text("9:35 to 10:35"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(
                              left: 120,
                              right: 120,
                            )),
                        child: Text("9:35 to 10:35"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(
                              left: 120,
                              right: 120,
                            )),
                        child: Text("9:35 to 10:35"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(
                              left: 120,
                              right: 120,
                            )),
                        child: Text("9:35 to 10:35"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(
                              left: 120,
                              right: 120,
                            )),
                        child: Text("9:35 to 10:35"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 30,
                          ),

                        ),
                        child: Text("BOOk AV HALL"),
                      ),
                    ],
                  ),
                if (selectedValue == 2)
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                            left: 120,
                            right: 120,
                          ),
                          backgroundColor: Colors.lightGreen,
                        ),
                        child: Text("9:35 to 10:35"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                            left: 120,
                            right: 120,
                          ),
                          backgroundColor: Colors.lightGreen,
                        ),
                        child: Text("9:35 to 10:35"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                            left: 120,
                            right: 120,
                          ),
                          backgroundColor: Colors.lightGreen,
                        ),
                        child: Text("9:35 to 10:35"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                            left: 120,
                            right: 120,
                          ),
                          backgroundColor: Colors.lightGreen,
                        ),
                        child: Text("9:35 to 10:35"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                            left: 120,
                            right: 120,
                          ),
                          backgroundColor: Colors.lightGreen,
                        ),
                        child: Text("9:35 to 10:35"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                            left: 120,
                            right: 120,
                          ),
                          backgroundColor: Colors.lightGreen,
                        ),
                        child: Text("9:35 to 10:35"),
                      ),
                      ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 30,
                          ),
                          backgroundColor:
                          const Color.fromARGB(255, 41, 8, 134),
                        ),
                        child: Text("BOOk AV HALL"),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}

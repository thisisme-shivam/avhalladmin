import 'package:flutter/material.dart';

import '../controller/AVHallController.dart';
import '../dialogs/DialogHelper.dart';

class AddNewHall extends StatefulWidget {
  const AddNewHall({super.key});

  @override
  State<AddNewHall> createState() => _AddNewHallState();
}

class _AddNewHallState extends State<AddNewHall> {
  final TextEditingController avHallController = TextEditingController();

  Future<void> _onAddHallPressed(BuildContext context) async {
    String avHallName = avHallController.text;
    DialogHelper.showLoadingDialog(
      context,
    );
    bool isSaved = await AVHallController.saveAVHall(avHallName);
    if(isSaved){
      DialogHelper.hideLoadingDialog(context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Hall')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: avHallController,
            decoration: InputDecoration(labelText: 'Hall Name'),
          ),
          ElevatedButton(
            onPressed: () {
              _onAddHallPressed(context);
            },
            child: Text("Add Hall"),
          ),
        ],
      ),
    );
  }
}

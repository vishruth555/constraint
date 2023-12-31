import 'package:constraint/state_management.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StringDataPopup extends StatefulWidget {
  @override
  _StringDataPopupState createState() => _StringDataPopupState();
}

class _StringDataPopupState extends State<StringDataPopup> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Group Name'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(labelText: 'Enter here'),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  _printGroups(); // Close the popup
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Save the string data and close the popup
                  _saveStringData();
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _printGroups() {
    final change = context.read<Manager>();
    change.printAllGroups();
  }

  void _saveStringData() {
    // Implement your logic to save the string data
    String enteredData = _textEditingController.text;
    final change = context.read<Manager>();
    change.createNewGroup(enteredData);
    // print('String Data Saved: $enteredData');
    // You can handle the data as needed, for example, saving it to a database or updating the UI.
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}

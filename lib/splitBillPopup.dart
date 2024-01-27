import 'package:constraint/dataModel.dart';
import 'package:constraint/state_management.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:constraint/groupPage.dart';

import 'addMembers.dart';

enum DisplayOption { evenly, custom }

class SplitBillPopup extends StatefulWidget {
  Group group;
  SplitBillPopup({required this.group});
  @override
  _SplitBillPopupState createState() => _SplitBillPopupState();
}

class _SplitBillPopupState extends State<SplitBillPopup> {
  TextEditingController _amountEditingController = TextEditingController();
  TextEditingController _subjectEditingController = TextEditingController();
  double amount = 0.0;
  DisplayOption _selectedOption = DisplayOption.evenly;

  @override
  Widget build(BuildContext context) {
    final members = widget.group.members;
    int membersLength = members != null ? members.length : 0;
    return AlertDialog(
      // title: const Text('Enter Split Amount'),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_outlined)),
          const Text('Enter Split Amount')
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _subjectEditingController,
            decoration: const InputDecoration(labelText: 'Enter the purpose'),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: _amountEditingController,
            onChanged: (value) {
              setState(() {
                amount = double.parse(value);
              });
            },
            decoration: const InputDecoration(labelText: 'Enter Amount'),
          ),
          const SizedBox(height: 32),
          if (amount != 0.0 && membersLength != 0)
            Text('each has to pay ${amount / membersLength}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              print(membersLength);
              // // Save the string data and close the popup
              // Navigator.of(context).pop();
              // _saveStringData();
            },
            child: Text('Split'),
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
    String enteredData = _amountEditingController.text;
    final change = context.read<Manager>();
    change.createNewGroup(enteredData);
    print(change.groupLength - 1);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddMembers(
                  groupID: change.groupLength - 1,
                  editList: true,
                )));
    // MaterialPageRoute(
    //     builder: (context) => GroupPage(groupID: change.groupLength - 1)));
    // print('String Data Saved: $enteredData');
    // You can handle the data as needed, for example, saving it to a database or updating the UI.
  }

  @override
  void dispose() {
    _amountEditingController.dispose();
    super.dispose();
  }
}

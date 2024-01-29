import 'package:constraint/dataModel.dart';
import 'package:constraint/state_management.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:constraint/groupPage.dart';

import 'addMembers.dart';

enum DisplayOption { evenly, custom }

class SplitBillPopup extends StatefulWidget {
  int id;
  Group group;
  SplitBillPopup({required this.group, required this.id});
  @override
  _SplitBillPopupState createState() => _SplitBillPopupState();
}

class _SplitBillPopupState extends State<SplitBillPopup> {
  TextEditingController _amountEditingController = TextEditingController();
  TextEditingController _subjectEditingController = TextEditingController();
  double amount = 0.0;
  DisplayOption _selectedOption = DisplayOption.evenly;
  List<Expense> expenses = [];
  int len = 0;

  @override
  Widget build(BuildContext context) {
    final members = widget.group.members;
    int membersLength = members != null ? members.length : 0;
    return Consumer<Manager>(
        builder: (context, value, child) => AlertDialog(
              // title: const Text('Enter Split Amount'),
              title: const Text('Enter Split Amount'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _subjectEditingController,
                    decoration:
                        const InputDecoration(labelText: 'Enter the purpose'),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _amountEditingController,
                    onChanged: (value) {
                      setState(() {
                        amount = double.parse(value);
                      });
                    },
                    decoration:
                        const InputDecoration(labelText: 'Enter Amount'),
                  ),
                  const SizedBox(height: 32),
                  if (amount != 0.0 && membersLength != 0)
                    Text('each has to pay ${amount / membersLength}'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text('custom')),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print(membersLength);
                          final obj = context.read<Manager>();
                          print(obj.getBudget(widget.group));
                          print(widget.id);
                          expenses = obj.groups[widget.id].expenses ?? [];
                          len = expenses.length;
                          Expense expense = Expense(
                            id: len,
                            title: _subjectEditingController.text,
                            amount: amount,
                            time: DateTime.now(),
                          );
                          // obj.addExpense(widget.id, expense);
                          expenses.add(expense);
                          print(expenses);
                          obj.addExpense(widget.id, expenses, amount,
                              amount / membersLength);

                          // // Save the string data and close the popup
                          Navigator.of(context).pop();
                        },
                        child: Text('Split'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('cancel')),
                    ],
                  ),
                ],
              ),
            ));
  }

  @override
  void dispose() {
    _amountEditingController.dispose();
    super.dispose();
  }
}

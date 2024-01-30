import 'dart:ffi';
import 'dart:math';

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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            // Push a new route to enter custom values for each member
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomSplitPopup(
                                    groupId: widget.id,
                                    group: widget.group,
                                    amount: amount,
                                    title: _subjectEditingController.text,
                                  ),
                                ));
                          },
                          child: Text('custom')),
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
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('cancel')),
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

class CustomSplitPopup extends StatelessWidget {
  final int groupId;
  final Group group;
  final double amount;
  final String title;

  const CustomSplitPopup(
      {required this.group,
      required this.amount,
      required this.title,
      required this.groupId});

  @override
  Widget build(BuildContext context) {
    final members = group.members;
    final obj = context.read<Manager>();
    return Consumer<Manager>(
        builder: (context, value, child) => AlertDialog(
              title: Text('Enter Custom Split'),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final member in members!)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(member.name)),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: 'Enter amount for ${member.name}'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                member.temp = double.parse(value);
                                // Handle custom amount input for each member
                              },
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle custom split logic here
                            double expense = 0;
                            for (Member member in members) {
                              member.budget -= member.temp ?? 0;
                              expense += member.temp ?? 0;
                            }
                            obj.groups[groupId].members = members;
                            obj.groups[groupId].totalBudget =
                                (obj.groups[groupId].totalBudget! - expense)!;
                            print('check here');
                            print(expense);
                            print(obj.groups[groupId].totalBudget);

                            final expenses = obj.groups[groupId].expenses ?? [];
                            final len = expenses.length;
                            Expense customExpense = Expense(
                              id: len,
                              title: title,
                              amount: expense,
                              time: DateTime.now(),
                            );
                            // obj.addExpense(widget.id, expense);
                            expenses.add(customExpense);

                            obj.groups[groupId].expenses = expenses;

                            obj.notifyListeners();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text('Split'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle custom split logic here
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}

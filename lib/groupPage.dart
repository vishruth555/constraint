import 'package:constraint/addMembers.dart';
import 'package:constraint/dataModel.dart';
import 'package:constraint/home.dart';
import 'package:constraint/splitBillPopup.dart';
import 'package:constraint/state_management.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatefulWidget {
  int groupID;
  GroupPage({required this.groupID});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  String groupName = '';
  @override
  Widget build(BuildContext context) {
    final obj = context.read<Manager>();
    groupName = obj.groups[widget.groupID].name;
    print(widget.groupID);
    obj.printCurrentGroup(widget.groupID);
    return Consumer<Manager>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      // Navigator.pop(context);
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomeScreen()));
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    }),
                title: Text(groupName),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddMembers(
                                      groupID: widget.groupID,
                                      editList: true,
                                    )));
                      },
                      icon: Icon(Icons.supervisor_account_rounded)),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.data_usage_outlined)),
                ],
              ),
              body: Center(
                child: Text(groupName),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.attach_money_rounded),
                onPressed: () {
                  _showSplitBillPopup(context, obj.groups[widget.groupID]);
                  print(obj.groups[widget.groupID].name);
                  List<Member>? members = obj.groups[widget.groupID].members;
                  for (Member member in members!) {
                    String name = member.name;
                    int id = member.id;
                    double budget = member.budget;
                    print('$id | $name | $budget');
                  }
                },
              ),
            ));
  }
}

void _showSplitBillPopup(BuildContext context, final group) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SplitBillPopup(group: group);
    },
  );
}

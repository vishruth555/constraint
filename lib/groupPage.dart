import 'package:constraint/addMembers.dart';
import 'package:constraint/dataModel.dart';
import 'package:constraint/splitBillPopup.dart';
import 'package:constraint/state_management.dart';
import 'package:constraint/stats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils.dart';

class GroupPage extends StatefulWidget {
  int groupID;
  GroupPage({super.key, required this.groupID});

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
    // List<Expense> expenses = obj.groups[widget.groupID].expenses ?? [];
    return Consumer<Manager>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: color1,
              appBar: AppBar(
                backgroundColor: color2,
                foregroundColor: basic1,
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
                title: Text(
                  groupName,
                  style: TextStyle(color: basic1),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddMembers(
                                      groupID: widget.groupID,
                                      editList: false,
                                    )));
                      },
                      icon: Icon(Icons.supervisor_account_rounded)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Stats(
                                      groupId: widget.groupID,
                                    )));
                      },
                      icon: Icon(Icons.data_usage_outlined)),
                ],
              ),
              body: Column(
                children: [
                  if (obj.groups[widget.groupID].expenses == null)
                    Center(
                      child: Text(
                          '$groupName has no expenses yet, start by \nclicking on the \$ icon below'),
                    )
                  else
                    Container(),
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          obj.groups[widget.groupID].expenses?.length ?? 0,
                      itemBuilder: (context, index) {
                        final time =
                            obj.groups[widget.groupID].expenses![index].time;
                        return Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          padding: EdgeInsets.all(16.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                obj.groups[widget.groupID].expenses![index]
                                    .title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '₹${obj.groups[widget.groupID].expenses![index].amount} paid on ${time.day}/${time.month}/${time.year} ${time.hour}:${time.minute}:${time.second}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.attach_money_rounded),
                onPressed: () {
                  _showSplitBillPopup(
                      context, obj.groups[widget.groupID], widget.groupID);
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

void _showSplitBillPopup(BuildContext context, final group, final id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SplitBillPopup(
        group: group,
        id: id,
      );
    },
  );
}

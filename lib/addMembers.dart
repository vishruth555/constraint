import 'package:constraint/groupPage.dart';
import 'package:constraint/state_management.dart';
import 'package:flutter/material.dart';
import 'package:constraint/dataModel.dart';
import 'package:provider/provider.dart';
import 'utils.dart';

class AddMembers extends StatefulWidget {
  int groupID;
  bool editList;
  AddMembers({super.key, required this.groupID, required this.editList});
  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  List<Member> members = [];
  int memberId = 0;
  String currentName = '';
  double currentBudget = 0.0;
  String groupName = '';

  @override
  void initState() {
    super.initState();
    final obj = context.read<Manager>();
    groupName = obj.groups[widget.groupID].name;
    members = obj.groups[widget.groupID].members ?? [];
    memberId = obj.groups[widget.groupID].members?.length ?? 0;
    // obj.addMembersAndBudget(widget.groupID, members);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: color1,
        appBar: AppBar(
          backgroundColor: color2,
          foregroundColor: basic1,
          title: Text('Members of $groupName'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              widget.editList
                  ? Text('enter the members and their budget')
                  : Container(),
              Expanded(
                child: ListView.builder(
                  itemCount: members.length + 1,
                  itemBuilder: (context, index) {
                    if (index == members.length) {
                      return widget.editList
                          ? buildAddMemberRow()
                          : Container();
                    } else {
                      return buildMemberRow(index);
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (widget.editList) {
                    print('Submitted Members: $members');
                    if (members.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('add some members'),
                        duration: Duration(seconds: 2),
                      ));
                      return;
                    }
                    int id = 0;
                    for (Member member in members) {
                      member.id = id;
                      id++;
                      print(member.id);
                    }
                    final obj = context.read<Manager>();
                    obj.addMembersAndBudget(widget.groupID, members);
                    print('----------');
                    obj.printAllGroups();
                  }
                  Navigator.pop(context);
                },
                child: widget.editList ? Text('save') : Text('go back'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddMemberRow() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
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
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                setState(() {
                  currentName = value;
                });
              },
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Budget'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  currentBudget = double.tryParse(value) ?? 0.0;
                });
              },
            ),
          ),
          IconButton(
            onPressed: () {
              final Member newMember = Member(
                  id: memberId,
                  name: currentName,
                  budget: currentBudget,
                  totalBudget: currentBudget);
              setState(() {
                currentName = '';
                currentBudget = 0.0;
                memberId++;
                members.add(newMember);
              });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget buildMemberRow(int index) {
    final Member member = members[index];

    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
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
      child: Row(
        children: [
          Expanded(
            child: widget.editList
                ? Text('Name: ${member.name} | Budget: ${member.budget}')
                : Text('${member.name} has ₹${member.budget} left'),
          ),
          widget.editList
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      members.removeAt(index);
                    });
                  },
                  icon: Icon(Icons.remove),
                )
              : SizedBox(
                  height: 50,
                ),
        ],
      ),
    );
  }
}

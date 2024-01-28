import 'package:constraint/groupPage.dart';
import 'package:constraint/state_management.dart';
import 'package:flutter/material.dart';
import 'package:constraint/dataModel.dart';
import 'package:provider/provider.dart';
import 'utils.dart';

class AddMembers extends StatefulWidget {
  int groupID;
  bool editList;
  AddMembers({required this.groupID, required this.editList});
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
  Widget build(BuildContext context) {
    final obj = context.read<Manager>();
    groupName = obj.groups[widget.groupID].name;
    members = obj.groups[widget.groupID].members ?? [];

    memberId = obj.groups[widget.groupID].members?.length ?? 0;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: color1,
        appBar: AppBar(
          backgroundColor: color2,
          foregroundColor: basic1,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Members'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('enter the members and their budget'),
              Expanded(
                child: ListView.builder(
                  itemCount: members.length + 1,
                  itemBuilder: (context, index) {
                    if (index == members.length) {
                      // Last item for adding new member
                      return buildAddMemberRow();
                    } else {
                      // Input fields for existing members
                      return buildMemberRow(index);
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Perform action on button press (e.g., submit the form)
                  print('Submitted Members: $members');
                  int id = 0;
                  for (Member member in members) {
                    member.id = id;
                    id++;
                    print(member.id);
                  }
                  obj.addMembersAndBudget(widget.groupID, members);
                  print('----------');
                  obj.printAllGroups();
                  widget.editList
                      ? Navigator.pop(context)
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  GroupPage(groupID: widget.groupID)));
                },
                child: widget.editList ? Text('save') : Text('Submit'),
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
                // Handle name input
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
                // Handle budget input
                setState(() {
                  currentBudget = double.tryParse(value) ?? 0.0;
                });
              },
            ),
          ),
          IconButton(
            onPressed: () {
              // Create a new member with the entered values
              final Member newMember = Member(
                  id: memberId, name: currentName, budget: currentBudget);

              // Clear input fields
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
            child: Text('Name: ${member.name} | Budget: ${member.budget}'),
          ),
          IconButton(
            onPressed: () {
              // Remove the member from the list
              setState(() {
                members.removeAt(index);
              });
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

import 'package:constraint/groupPage.dart';
import 'package:constraint/state_management.dart';
import 'package:flutter/material.dart';
import 'package:constraint/dataModel.dart';
import 'package:provider/provider.dart';

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
    // groupName = obj.recentGroupName;
    // print('--------');
    // print(widget.groupID);
    groupName = obj.groups[widget.groupID].name;
    widget.editList
        ? members = obj.groups[widget.groupID].members ?? []
        : members = [];
    widget.editList
        ? memberId = obj.groups[widget.groupID].members?.length ?? 0
        : memberId = 0;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(groupName),
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
                                  GroupPage(groupID: widget.groupID - 1)));
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
    return Row(
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
              currentBudget = double.tryParse(value) ?? 0.0;
            },
          ),
        ),
        IconButton(
          onPressed: () {
            // Create a new member with the entered values
            final Member newMember =
                Member(id: memberId, name: currentName, budget: currentBudget);
            members.add(newMember);
            setState(() {
              memberId++;
            });
            print(newMember.name);
            print(newMember.id);

            // Clear input fields
            setState(() {
              currentName = '';
              currentBudget = 0.0;
            });
            // (You may want to use a state management solution for this)
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  Widget buildMemberRow(int index) {
    final Member member = members[index];

    return Row(
      children: [
        Expanded(
          child: Text(
              'ID: ${member.id} | Name: ${member.name} | Budget: ${member.budget}'),
        ),
        IconButton(
          onPressed: () {
            // Remove the member from the list
            print(members);
            members.removeAt(index);
            print(members);
            setState(() {
              memberId;
            });

            // (You may want to use a state management solution for this)
          },
          icon: Icon(Icons.remove),
        ),
      ],
    );
  }
}

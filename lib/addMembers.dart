import 'package:flutter/material.dart';
import 'package:constraint/dataModel.dart';

class AddMembers extends StatefulWidget {
  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  final List<Member> members = [];

  int memberId = 1;
  String currentName = '';
  double currentBudget = 0.0;
  // Initial member ID
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Member Input Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
                },
                child: Text('Submit'),
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

import 'package:constraint/addMembers.dart';
import 'package:constraint/state_management.dart';
import 'package:constraint/dataModel.dart';
import 'package:flutter/material.dart';
import 'package:constraint/group.dart';
import 'package:constraint/stringPopup.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Manager>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: const Color.fromRGBO(158, 200, 185, 1),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(9, 38, 53, 0.95),
            title: const Text(
              'Constraint',
              style: TextStyle(color: Colors.white),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const GroupPage()));
              // _showStringDataPopup(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddMembers()));

              // final change = context.read<Manager>();
              // change.changeText();
            },
            child: const Icon(Icons.add),
          ),
          body: value.groupLength == 0
              ? const Center(
                  child: Text('Tap the + to get started'),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: value.groupLength,
                    itemBuilder: (BuildContext context, int index) {
                      final groups = value.groups;
                      return buildGroupCard(groups[index]);
                    },
                  ),
                )),
    );
  }

  Widget buildGroupCard(Group group) {
    return GestureDetector(
      onTap: () {
        // Handle the onTap event
      },
      child: Card(
        elevation: 4, // Add elevation for box shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(27, 66, 66, 1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    group.name,
                    style: const TextStyle(
                        fontSize: 25, // Larger text size
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(158, 200, 185, 1)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'members: ${group.members?.length ?? 0} \nBudget: ${group.totalBudget ?? 0}',
                    style: TextStyle(
                      fontSize: 18, // Smaller text size
                      color: Color.fromRGBO(92, 131, 116, 1),
                    ),
                  ),
                ),
                const Spacer(), // Add Spacer to push the containers to the bottom
                Container(
                  height: 10,
                  color:
                      const Color.fromRGBO(92, 131, 116, 1), // Solid color bar
                ),
                const SizedBox(height: 8), // Add some spacing
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showStringDataPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StringDataPopup();
    },
  );
}

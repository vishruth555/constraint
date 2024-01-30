import 'package:constraint/addMembers.dart';
import 'package:constraint/groupPage.dart';
import 'package:constraint/state_management.dart';
import 'package:constraint/dataModel.dart';
import 'package:flutter/material.dart';
import 'package:constraint/group.dart';
import 'package:constraint/stringPopup.dart';
import 'package:provider/provider.dart';
import 'utils.dart';

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
          backgroundColor: color1,
          appBar: AppBar(
            backgroundColor: color2,
            title: const Text(
              'Constraint',
              style: TextStyle(color: basic1),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const GroupPage()));
              _showStringDataPopup(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => AddMembers()));

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
                      return buildGroupCard(groups[index], index);
                    },
                  ),
                )),
    );
  }

  Widget buildGroupCard(Group group, int id) {
    double width = (group.totalBudget ?? 0.0) / (group.budget ?? 1.0);
    if (width == 0 || width.isNaN) {
      width = 0.1;
    }
    return GestureDetector(
      onTap: () {
        // Handle the onTap event
        print(id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GroupPage(
                      groupID: id,
                    )));
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
                color: basic1,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    group.name,
                    style: const TextStyle(
                        fontSize: 25, // Larger text size
                        fontWeight: FontWeight.bold,
                        color: color4),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'members: ${group.members?.length ?? 0} \nBudget: ${group.totalBudget ?? 0}',
                    style: TextStyle(
                      fontSize: 18, // Smaller text size
                      color: color4,
                    ),
                  ),
                ),
                const Spacer(), // Add Spacer to push the containers to the bottom
                FractionallySizedBox(
                  widthFactor: width,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: color1,
                    ),
                    height: 10, // Solid color bar
                  ),
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

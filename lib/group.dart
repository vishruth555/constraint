// import 'package:constraint/state_management.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class GroupPage extends StatefulWidget {
//   const GroupPage({super.key});
//
//   @override
//   State<GroupPage> createState() => _GroupPageState();
// }
//
// class _GroupPageState extends State<GroupPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Manager>(
//         builder: (context, value, child) => Scaffold(
//               appBar: AppBar(
//                 leading: IconButton(
//                     icon: Icon(Icons.arrow_back_ios_new_rounded),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     }),
//                 title: Text(value.recentGroupName),
//               ),
//               body: Center(
//                 child: Text('this is the group${value.recentGroupName}'),
//               ),
//             ));
//   }
// }

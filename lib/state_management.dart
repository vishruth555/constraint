import 'package:flutter/cupertino.dart';
import 'package:constraint/dataModel.dart';

class Manager extends ChangeNotifier {
  String _test = 'this is a test';
  String get test => _test;

  List<Group> _groups = [];
  List<Group> get groups => _groups;

  int get groupLength => _groups.length;
  String _recentGroupName = '';
  String get recentGroupName => _recentGroupName;

  void changeText() {
    _test = 'it changed';
    notifyListeners();
  }

  void createNewGroup(String name) {
    Group newGroup = Group(
      id: groupLength,
      name: name,
    );
    _groups.add(newGroup);
    _recentGroupName = name;
    notifyListeners();
  }

  void addMembersAndBudget(int index, List<Member> members) {
    _groups[index].members = members;
    double _totalBudget = 0;
    for (Member member in members) {
      _totalBudget += member.budget;
    }
    _groups[index].totalBudget = _totalBudget;
    notifyListeners();
  }

  void printAllGroups() {
    for (Group group in _groups) {
      print('Group ID: ${group.id}');
      print('Group Name: ${group.name}');
      print('Group Budget: ${group.totalBudget}');
      print('Group Members: ${group.members}');
      print('Group Expenses: ${group.expenses}');
      print('-------------------------');
    }
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:constraint/dataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void printCurrentGroup(int id) {
    Group group = _groups[id];
    print('Group ID: ${group.id}');
    print('Group Name: ${group.name}');
    print('Group Budget: ${group.totalBudget}');
    print('Group Members: ${group.members}');
    print('Group Expenses: ${group.expenses}');
    print('-------------------------');
  }

  double? getBudget(Group group) {
    return group.totalBudget;
  }

  void addExpense(
      int id, List<Expense> expenses, double amount, double eachAmount) {
    print(_groups[id].totalBudget);
    print('check here');
    _groups[id].expenses = expenses;
    _groups[id].totalBudget = _groups[id].totalBudget! - amount;
    print(_groups[id].totalBudget);
    List<Member>? members = _groups[id].members;
    for (Member member in members!) {
      member.budget -= eachAmount;
    }
    notifyListeners();
  }

  // void customExpense(int id, List<Expense> expenses) {
  //   _groups[id].expenses = expenses;
  //   notifyListeners();
  // }

  void addMembersAndBudget(int index, List<Member> members) {
    _groups[index].members = members;
    double _totalBudget = 0;
    for (Member member in members) {
      _totalBudget += member.budget;
    }
    _groups[index].totalBudget = _totalBudget;
    _groups[index].budget = _totalBudget;
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

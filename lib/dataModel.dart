class Group {
  int id;
  String name;
  double? totalBudget;
  List<Member>? members;
  List<Expense>? expenses;

  Group(
      {required this.id,
      required this.name,
      this.totalBudget,
      this.members,
      this.expenses});
}

class Member {
  int id;
  String name;
  double budget;

  Member({required this.id, required this.budget, required this.name});
}

class Expense {
  int id;
  String title;
  double amount;
  // Member paidBy;
  List<Member> splitAmong;

  Expense(
      {required this.id,
      required this.title,
      required this.amount,
      // required this.paidBy,
      required this.splitAmong});
}

class Group {
  int id;
  String name;
  double? totalBudget;
  List<Member>? members;
  List<Expense>? expenses;
  double? budget;

  Group(
      {required this.id,
      required this.name,
      this.totalBudget,
      this.members,
      this.expenses,
      this.budget});
}

class Member {
  int id;
  String name;
  double budget;
  double? totalBudget;
  double? temp;

  Member(
      {required this.id,
      required this.budget,
      required this.name,
      this.totalBudget,
      this.temp});
}

class Expense {
  int id;
  String title;
  double amount;
  DateTime time;
  // Member paidBy;
  // List<Member> splitAmong;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.time,
    // required this.paidBy,
    // required this.splitAmong
  });
}

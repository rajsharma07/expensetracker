class Debt {
  final String datetime;
  final String title;
  final String lender;
  final String duedate;
  final int amount;
  Debt({
    required this.datetime,
    required this.title,
    required this.duedate,
    required this.lender,
    required this.amount,
  });
}

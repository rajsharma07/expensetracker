class ExpenseModel {
  final String datetime;
  final String title;
  final String userId;
  final int category;
  final int amount;
  final String source;
  ExpenseModel(
      {required this.datetime,
      required this.title,
      required this.userId,
      required this.source,
      required this.category,
      required this.amount});
}

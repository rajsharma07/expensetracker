class IncomeModel {
  final String datetime;
  final String title;
  final String userId;
  final String source;
  final int category;
  final int amount;
  IncomeModel(
      {required this.datetime,
      required this.title,
      required this.userId,
      required this.source,
      required this.category,
      required this.amount});
}

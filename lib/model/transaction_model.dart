class TransactionModel {
  int id;
  String transactionType;
  String title;
  String category;
  String date;
  int amount;

  TransactionModel(
      {required this.id,
      required this.transactionType,
      required this.title,
      required this.category,
      required this.date,
      required this.amount});
}

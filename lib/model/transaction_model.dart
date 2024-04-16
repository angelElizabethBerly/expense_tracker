class TransactionModel {
  int id;
  String transactionType;
  String title;
  String category;
  String date;
  int amount;
  int balanceAmount;
  int totalIncome;
  int totalExpense;

  TransactionModel(
      {required this.id,
      required this.transactionType,
      required this.title,
      required this.category,
      required this.date,
      required this.amount,
      this.balanceAmount = 1000,
      this.totalIncome = 0,
      this.totalExpense = 0});
}

class BankTransaction {
  final String id;
  final String fromAccountId;
  final String toAccountId;
  final double amount;
  final String currency;
  final DateTime date;
  final String note;

  BankTransaction({
    required this.id,
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.currency,
    required this.date,
    required this.note,
  });
}

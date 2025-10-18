import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saamba_demo/models/transaction.dart';
import '../models/account.dart';

class FXController extends GetxController {
  /// --- Reactive Data ---
  final rates =
      <String, double>{
        'USD': 280.50,
        'EUR': 305.20,
        'GBP': 360.75,
        'JPY': 1.95,
        'AED': 76.40,
      }.obs;

  final accounts = <Account>[].obs;
  final transactions = <BankTransaction>[].obs;
  // final rates = <FXRate>[].obs;

  /// --- Initialization ---
  @override
  void onInit() {
    super.onInit();

    // Seed mock accounts
    accounts.addAll([
      Account(id: 'A-001', currency: 'PKR', balance: 250000.00),
      Account(id: 'A-002', currency: 'USD', balance: 1200.00),
      Account(id: 'A-003', currency: 'EUR', balance: 300.00),
    ]);

    // Seed mock transactions
    transactions.addAll([
      BankTransaction(
        id: 'T-100',
        fromAccountId: 'A-001',
        toAccountId: 'A-002',
        amount: 56000,
        currency: 'PKR',
        date: DateTime.now().subtract(const Duration(days: 2)),
        note: 'FX buy USD',
      ),
      BankTransaction(
        id: 'T-101',
        fromAccountId: 'A-002',
        toAccountId: 'A-001',
        amount: 200,
        currency: 'USD',
        date: DateTime.now().subtract(const Duration(days: 5)),
        note: 'USD sale',
      ),
    ]);
  }

  /// --- Helpers ---
  String fmtCurrency(double value, String currency) {
    final f = NumberFormat.currency(locale: 'en_US', name: '$currency ');
    return f.format(value);
  }

  double convert(double amount, String from, String to) {
    if (from == to) return amount;

    final fromRate = rates[from] ?? 1.0;
    final toRate = rates[to] ?? 1.0;

    // Convert to PKR first
    double amountInPKR = from == 'PKR' ? amount : amount * fromRate;

    // Convert PKR to target currency
    return to == 'PKR' ? amountInPKR : amountInPKR / toRate;
  }

  /// --- Perform FX / Transfer Operation ---
  Future<bool> performFX({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String currency,
    String? note,
  }) async {
    final from = accounts.firstWhereOrNull((a) => a.id == fromAccountId);
    final to = accounts.firstWhereOrNull((a) => a.id == toAccountId);

    if (from == null || to == null) return false;
    if (from.balance < amount) return false;

    final converted = convert(amount, from.currency, to.currency);

    // Update balances
    from.balance -= amount;
    to.balance += converted;

    // Create transaction record
    transactions.insert(
      0,
      BankTransaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        currency: from.currency,
        date: DateTime.now(),
        note: note ?? 'FX Transfer',
      ),
    );

    // Refresh observable lists
    accounts.refresh();
    transactions.refresh();

    return true;
  }
}

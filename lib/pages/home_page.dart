import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saamba_demo/controllers/main_nav_controller.dart';
import '../controllers/fx_controller.dart';
import '../models/account.dart';

class HomePage extends StatelessWidget {
  final FXController fx = Get.find();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0071BC), Color(0xFF1DA1F2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (fx.accounts.isEmpty) {
              return const Center(
                child: Text(
                  'No accounts available',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🏦 Logo at top
                  Image.asset(
                    'assets/images/Samba_Bank_Logo.png',
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),

                  // 💰 Accounts list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: fx.accounts.length,
                    itemBuilder: (context, i) {
                      final acc = fx.accounts[i];
                      return AccountCard(account: acc, fx: fx);
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  final Account account;
  final FXController fx;

  const AccountCard({super.key, required this.account, required this.fx});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade400,
          child: const Icon(Icons.account_balance_wallet, color: Colors.white),
        ),
        title: Text(
          'Account ${account.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(account.currency),
        trailing: Obx(() {
          final updated = fx.accounts.firstWhereOrNull(
            (a) => a.id == account.id,
          );
          final bal = updated?.balance ?? account.balance;
          return Text(
            fx.fmtCurrency(bal, account.currency),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          );
        }),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.currency_exchange, size: 18),
                    label: const Text('Convert / Transfer'),
                    // onPressed:
                    //     () => Get.to(() => ConvertPage(), arguments: account),
                    onPressed: () {
                      if (Get.isRegistered<MainNavController>()) {
                        final nav = Get.find<MainNavController>();
                        nav.setIndex(2); // index of ConvertPage
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      elevation: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
            child: Text(
              'Recent Transactions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Obx(() {
            final txs =
                fx.transactions
                    .where(
                      (t) =>
                          t.fromAccountId == account.id ||
                          t.toAccountId == account.id,
                    )
                    .take(3)
                    .toList();

            if (txs.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text('   No recent transactions'),
              );
            }

            return Column(
              children:
                  txs.map((t) {
                    final isDebit = t.fromAccountId == account.id;
                    return ListTile(
                      dense: true,
                      leading: Icon(
                        isDebit
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        color: isDebit ? Colors.redAccent : Colors.green,
                      ),
                      title: Text(
                        t.note ?? "Note From The API Will Be Recieved",
                      ),
                      subtitle: Text('${t.amount} ${t.currency}'),
                      trailing: Text(
                        '${t.date.day}/${t.date.month}/${t.date.year}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

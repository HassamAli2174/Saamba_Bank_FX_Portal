// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/fx_controller.dart';
// import '../models/account.dart';

// class AccountPage extends StatelessWidget {
//   final FXController fx = Get.find();

//   AccountPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Account? a = Get.arguments is Account ? Get.arguments as Account : null;

//     // If no account is passed, show fallback UI
//     if (a == null) {
//       return Scaffold(
//         appBar: AppBar(title: const Text('Account Details')),
//         body: const Center(
//           child: Text(
//             '⚠ No account selected',
//             style: TextStyle(fontSize: 16, color: Colors.redAccent),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Account ${a.id}'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 🧾 Account summary
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.blue.shade100),
//               ),
//               child: Obx(() {
//                 final updated = fx.accounts.firstWhereOrNull((acc) => acc.id == a.id);
//                 final balance = updated?.balance ?? a.balance;

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Currency: ${a.currency}',
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       'Balance: ${fx.fmtCurrency(balance, a.currency)}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: Colors.blueAccent,
//                       ),
//                     ),
//                   ],
//                 );
//               }),
//             ),

//             const SizedBox(height: 16),

//             // 🔁 Convert / Transfer button
//             Center(
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.currency_exchange),
//                 label: const Text('Convert / Transfer'),
//                 style: ElevatedButton.styleFrom(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () => Get.toNamed('/convert', arguments: a),
//               ),
//             ),

//             const SizedBox(height: 20),
//             const Text(
//               'Recent Transactions',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             const SizedBox(height: 8),

//             // 📜 Transaction list
//             Expanded(
//               child: Obx(() {
//                 final txs = fx.transactions
//                     .where((t) => t.fromAccountId == a.id || t.toAccountId == a.id)
//                     .toList();

//                 if (txs.isEmpty) {
//                   return const Center(
//                     child: Text('No transactions found'),
//                   );
//                 }

//                 return ListView.builder(
//                   itemCount: txs.length,
//                   itemBuilder: (context, i) {
//                     final t = txs[i];
//                     final isDebit = t.fromAccountId == a.id;

//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 6),
//                       child: ListTile(
//                         leading: Icon(
//                           isDebit
//                               ? Icons.arrow_upward_rounded
//                               : Icons.arrow_downward_rounded,
//                           color: isDebit ? Colors.redAccent : Colors.green,
//                         ),
//                         title: Text(t.note),
//                         subtitle: Text(
//                           '${t.amount} ${t.currency}',
//                           style: const TextStyle(fontSize: 13),
//                         ),
//                         trailing: Text(
//                           '${t.date.day}/${t.date.month}/${t.date.year}',
//                           style: const TextStyle(fontSize: 12, color: Colors.grey),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/fx_controller.dart';

class TransactionsPage extends StatelessWidget {
  final FXController fx = Get.find();

  TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
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
            final txs = fx.transactions;

            if (txs.isEmpty) {
              return const Center(
                child: Text(
                  'No transactions yet.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  // child: Row(
                    // children: const [
                //       Icon(Icons.receipt_long, color: Colors.white, size: 30),
                //       SizedBox(width: 10),
                //       Text(
                //         'Transaction History',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 22,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // Transactions List
                Expanded(
                  child: 
                  // child: Container(
                  //   width: double.infinity,
                  //   decoration: const BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(24),
                  //       topRight: Radius.circular(24),
                  //     ),
                  //   ),
                    Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0071BC), Color(0xFF1DA1F2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: txs.length,
                      itemBuilder: (context, i) {
                        final t = txs[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.blue.shade100,
                                child: const Icon(Icons.swap_horiz, color: Colors.blueAccent),
                              ),
                              title: Text(
                                '${t.fromAccountId} → ${t.toAccountId}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      t.note.isNotEmpty ? t.note : 'No note',
                                      style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 11, color: Colors.black87),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            size: 14, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${t.date.day}/${t.date.month}/${t.date.year}',
                                          style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 11,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${t.amount.toStringAsFixed(0)} ${t.currency}',
                                    style: const TextStyle(
                                      // color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/fx_controller.dart';

// class TransactionsPage extends StatelessWidget {
//   final FXController fx = Get.find();

//   TransactionsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() {
//         final txs = fx.transactions;

//         if (txs.isEmpty) {
//           return const Center(child: Text('No transactions yet.'));
//         }

//         return ListView.builder(
//           itemCount: txs.length,
//           itemBuilder: (context, i) {
//             final t = txs[i];
//             return Card(
//               color: Colors.white,
//               margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               child: ListTile(
//                 leading: const Icon(
//                   Icons.receipt_long,
//                   color: Colors.blueAccent,
//                 ),
//                 title: Text(
//                   '${t.fromAccountId} → ${t.toAccountId}',
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       t.note.isNotEmpty ? t.note : 'No note',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '${t.date.day}/${t.date.month}/${t.date.year}',
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//                 trailing: Text(
//                   '${t.amount.toStringAsFixed(2)} ${t.currency}',
//                   style: const TextStyle(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

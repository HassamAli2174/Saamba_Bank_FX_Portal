import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/fx_controller.dart';
import '../models/account.dart';

class ConvertPage extends StatelessWidget {
  final FXController fx = Get.find();

  final fromAccount = Rx<Account?>(null);
  final toAccount = Rx<Account?>(null);
  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController();
  final convertedAmount = 0.0.obs;

  ConvertPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pre-select "From Account" if passed from AccountPage
    final arg = Get.arguments;
    if (arg is Account) fromAccount.value = arg;

    // Listen to amount input and auto-calculate conversion
    amountCtrl.addListener(() {
      final from = fromAccount.value;
      final to = toAccount.value;
      final amt = double.tryParse(amountCtrl.text) ?? 0;
      if (from != null && to != null && amt > 0) {
        convertedAmount.value = fx.convert(amt, from.currency, to.currency);
      } else {
        convertedAmount.value = 0;
      }
    });

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
        child: Obx(() {
          final accounts = fx.accounts;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Center(
                    child: Column(
                      children: const [
                        Icon(
                          Icons.currency_exchange,
                          size: 40,
                          color: Colors.blueAccent,
                        ),
                        // SizedBox(height: 8),
                        // Text(
                        //   'Convert / Transfer Funds',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 20,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // From Account
                  const Text(
                    'From Account',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<Account>(
                    value: fromAccount.value,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items:
                        accounts.map((acc) {
                          return DropdownMenuItem(
                            value: acc,
                            child: Text(
                              '${acc.id} (${acc.currency}) — ${fx.fmtCurrency(acc.balance, acc.currency)}',
                            ),
                          );
                        }).toList(),
                    onChanged: (val) {
                      fromAccount.value = val;
                      amountCtrl.clear();
                      convertedAmount.value = 0;
                    },
                  ),

                  const SizedBox(height: 20),

                  // To Account
                  const Text(
                    'To Account',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<Account>(
                    value: toAccount.value,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items:
                        accounts.map((acc) {
                          return DropdownMenuItem(
                            value: acc,
                            child: Text(
                              '${acc.id} (${acc.currency}) — ${fx.fmtCurrency(acc.balance, acc.currency)}',
                            ),
                          );
                        }).toList(),
                    onChanged: (val) {
                      toAccount.value = val;
                      amountCtrl.clear();
                      convertedAmount.value = 0;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Amount
                  TextField(
                    controller: amountCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.attach_money),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Note
                  TextField(
                    controller: noteCtrl,
                    decoration: InputDecoration(
                      labelText: 'Note (optional)',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.note_alt_outlined),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Conversion Result
                  Obx(() {
                    final from = fromAccount.value;
                    final to = toAccount.value;
                    final amt = double.tryParse(amountCtrl.text) ?? 0;

                    if (from == null || to == null || amt <= 0) {
                      return const SizedBox.shrink();
                    }

                    return Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'You will receive:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${convertedAmount.value.toStringAsFixed(0)} ${to.currency}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  // Button
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Perform Conversion'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      onPressed: () async {
                        final from = fromAccount.value;
                        final to = toAccount.value;
                        final amt = double.tryParse(amountCtrl.text) ?? 0;

                        if (from == null || to == null) {
                          Get.snackbar(
                            'Error',
                            'Select both accounts',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red.shade100,
                          );
                          return;
                        }
                        if (amt <= 0) {
                          Get.snackbar(
                            'Error',
                            'Enter a valid amount',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red.shade100,
                          );
                          return;
                        }

                        final ok = await fx.performFX(
                          fromAccountId: from.id,
                          toAccountId: to.id,
                          amount: amt,
                          currency: from.currency,
                          note: noteCtrl.text,
                        );

                        if (ok) {
                          Get.snackbar(
                            'Success',
                            'Conversion completed successfully!',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.green.shade100,
                          );
                          amountCtrl.clear();
                          noteCtrl.clear();
                          convertedAmount.value = 0;
                        } else {
                          Get.snackbar(
                            'Failed',
                            'Insufficient funds or error occurred',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red.shade100,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/fx_controller.dart';
// import '../models/account.dart';

// class ConvertPage extends StatelessWidget {
//   final FXController fx = Get.find();

//   final fromAccount = Rx<Account?>(null);
//   final toAccount = Rx<Account?>(null);
//   final amountCtrl = TextEditingController();
//   final noteCtrl = TextEditingController();
//   final convertedAmount = 0.0.obs;

//   ConvertPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // ✅ Pre-select "From Account" if passed from AccountPage
//     final arg = Get.arguments;
//     if (arg is Account) {
//       fromAccount.value = arg;
//     }

//     amountCtrl.addListener(() {
//       final from = fromAccount.value;
//       final to = toAccount.value;
//       final amt = double.tryParse(amountCtrl.text) ?? 0;
//       if (from != null && to != null && amt > 0) {
//         convertedAmount.value = fx.convert(amt, from.currency, to.currency);
//       } else {
//         convertedAmount.value = 0;
//       }
//     });

//     return Scaffold(
//       // appBar: AppBar(title: const Text('Convert / Transfer')),
//       body: Obx(() {
//         final accounts = fx.accounts;

//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'From Account',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               DropdownButtonFormField<Account>(
//                 // style: const TextStyle(color: Colors.white),
//                 value: fromAccount.value,
//                 items:
//                     accounts.map((acc) {
//                       return DropdownMenuItem(
//                         value: acc,
//                         child: Text(
//                           '${acc.id} (${acc.currency}) — ${fx.fmtCurrency(acc.balance, acc.currency)}',
//                         ),
//                       );
//                     }).toList(),
//                 onChanged: (val) {
//                   fromAccount.value = val;
//                   amountCtrl.text = '';
//                   convertedAmount.value = 0;
//                 },
//               ),
//               const SizedBox(height: 16),

//               const Text(
//                 'To Account',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               DropdownButtonFormField<Account>(
//                 // style: const TextStyle(backgroundColor: Colors.white),
//                 value: toAccount.value,
//                 items:
//                     accounts.map((acc) {
//                       return DropdownMenuItem(
//                         value: acc,
//                         child: Text(
//                           '${acc.id} (${acc.currency}) — ${fx.fmtCurrency(acc.balance, acc.currency)}',
//                         ),
//                       );
//                     }).toList(),
//                 onChanged: (val) {
//                   toAccount.value = val;
//                   amountCtrl.text = '';
//                   convertedAmount.value = 0;
//                 },
//               ),
//               const SizedBox(height: 16),

//               TextField(
//                 controller: amountCtrl,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: 'Amount',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               TextField(
//                 controller: noteCtrl,
//                 decoration: const InputDecoration(
//                   labelText: 'Note (optional)',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // 💱 Live conversion preview
//               Obx(() {
//                 final from = fromAccount.value;
//                 final to = toAccount.value;
//                 final amt = double.tryParse(amountCtrl.text) ?? 0;

//                 if (from == null || to == null || amt <= 0) {
//                   return const SizedBox.shrink();
//                 }

//                 return Container(
//                   padding: const EdgeInsets.all(12),
//                   margin: const EdgeInsets.only(bottom: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade50,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'You will receive:',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       Text(
//                         '${convertedAmount.value.toStringAsFixed(2)} ${to.currency}',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blueAccent,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }),

//               Center(
//                 child: ElevatedButton.icon(
//                   icon: const Icon(Icons.currency_exchange),
//                   label: const Text('Perform Conversion'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue[600],
//                     foregroundColor: Colors.white,
//                     elevation: 2,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 12,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: () async {
//                     final from = fromAccount.value;
//                     final to = toAccount.value;
//                     final amt = double.tryParse(amountCtrl.text) ?? 0;

//                     if (from == null || to == null) {
//                       Get.snackbar('Error', 'Select both accounts');
//                       return;
//                     }
//                     if (amt <= 0) {
//                       Get.snackbar('Error', 'Enter a valid amount');
//                       return;
//                     }

//                     final ok = await fx.performFX(
//                       fromAccountId: from.id,
//                       toAccountId: to.id,
//                       amount: amt,
//                       currency: from.currency,
//                       note: noteCtrl.text,
//                     );

//                     if (ok) {
//                       Get.snackbar('Success', 'Conversion successful');
//                       amountCtrl.clear();
//                       noteCtrl.clear();
//                       convertedAmount.value = 0;
//                     } else {
//                       Get.snackbar(
//                         'Failed',
//                         'Insufficient funds or error occurred',
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

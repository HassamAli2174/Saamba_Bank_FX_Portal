import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/fx_controller.dart';

class FXRatesPage extends StatelessWidget {
  final FXController fx = Get.find();

  FXRatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        // backgroundColor: Colors.white,
        title: const Text(
          'FX Rates',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: Obx(() {
        final rateEntries = fx.rates.entries.toList();

        if (rateEntries.isEmpty) {
          return const Center(
            child: Text(
              'No FX rates available',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: rateEntries.length,
          itemBuilder: (context, i) {
            final entry = rateEntries[i];
            final currency = entry.key;
            final rate = entry.value;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue.shade50.withOpacity(0.4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22,
                  backgroundColor: primary.withOpacity(0.15),
                  child: const Icon(
                    Icons.currency_exchange_rounded,
                    color: Colors.blueAccent,
                    size: 26,
                  ),
                ),
                title: Text(
                  'PKR → $currency',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                // subtitle: Text(
                //   'Updated just now',
                //   style: TextStyle(color: Colors.grey[600], fontSize: 12),
                // ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: primary.withOpacity(0.3)),
                  ),
                  child: Text(
                    rate.toStringAsFixed(2),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primary,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/fx_controller.dart';

// class FXRatesPage extends StatelessWidget {
//   final FXController fx = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('FX Rates')),
//       body: Obx(() {
//         final rateEntries = fx.rates.entries.toList();
//         if (rateEntries.isEmpty) {
//           return const Center(child: Text('No FX rates available'));
//         }

//         return ListView.builder(
//           itemCount: rateEntries.length,
//           itemBuilder: (context, i) {
//             final entry = rateEntries[i];
//             final currency = entry.key;
//             final rate = entry.value;

//             return Card(
//               color: Colors.white,
//               margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: ListTile(
//                 leading: const Icon(
//                   Icons.currency_exchange,
//                   color: Colors.blueAccent,
//                 ),
//                 title: Text(
//                   'PKR → $currency',
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 trailing: Text(
//                   rate.toStringAsFixed(2),
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
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

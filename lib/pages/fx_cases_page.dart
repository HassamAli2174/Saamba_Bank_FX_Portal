import 'package:flutter/material.dart';
import 'it_related_designation_page.dart'; 

class FXCasesPage extends StatefulWidget {
  const FXCasesPage({super.key});

  @override
  State<FXCasesPage> createState() => _FXCasesPageState();
}

class _FXCasesPageState extends State<FXCasesPage> {
  //--------For independent dropdown--------

  // final List<String> caseTypes = [
  //   'Conversion',
  //   'Transfer',
  //   'Rate Request',
  //   'Trade Finance',
  // ];
  // final List<String> caseTitles = [
  //   'USD to PKR Transfer',
  //   'EUR to GBP Conversion',
  //   'Rate Approval Request',
  //   'LC Amendment Case',
  // ];

  //----------For dependent dropdown
  final Map<String, List<String>> caseOptions = {
    'Designation & Acknowledgement':[
      'IT Related Designation'
    ],
    'Rate Request': [
      'New Rate Inquiry',
      'Rate Mismatch',
      'Preferred Currency Rate',
    ],
    'Transfer Issue': [
      'Delayed Transfer',
      'Incorrect Beneficiary',
      'Transfer Cancellation',
    ],
    'Transaction Dispute': [
      'Unauthorized Transaction',
      'Duplicate Charge',
      'Reversal Request',
    ],
  };

  // String? selectedType;
  // String? selectedTitle;
  String? selectedCaseType;
  String? selectedCaseTitle;
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
          //       const SizedBox(height: 24),
          //       const Text(
          //         'FX Cases',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 26,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       const SizedBox(height: 32),

                // 🔹 Case Type Dropdown
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Select Case Type',
                    ),
                    value: selectedCaseType,
                    items:
                        caseOptions.keys
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCaseType = value;
                        selectedCaseTitle = null; // reset dependent dropdown
                      });
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // 🔸 Case Title Dropdown (dependent)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Select Case Title',
                    ),
                    value: selectedCaseTitle,
                    items:
                        (selectedCaseType == null)
                            ? []
                            : caseOptions[selectedCaseType]!
                                .map(
                                  (title) => DropdownMenuItem(
                                    value: title,
                                    child: Text(title),
                                  ),
                                )
                                .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCaseTitle = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 40),

                // Button
                ElevatedButton.icon(
                  onPressed:
                      (selectedCaseType != null && selectedCaseTitle != null)
                          ? () {
                            if (selectedCaseType ==
                                  'Designation & Acknowledgement' &&
                              selectedCaseTitle == 'IT Related Designation') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ItRelatedDesignationPage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Selected "$selectedCaseTitle" under "$selectedCaseType"',
                                ),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                      : null,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text(
                    'Select',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//----------For independent Dropdown--------------------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF0071BC), Color(0xFF1DA1F2)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text(
//                   'FX Cases',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // 🧾 Dropdown for Case Type
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: DropdownButton<String>(
//                     value: selectedType,
//                     isExpanded: true,
//                     underline: const SizedBox(),
//                     hint: const Text('Select Case Type'),
//                     items: caseTypes
//                         .map(
//                           (type) => DropdownMenuItem(
//                             value: type,
//                             child: Text(type),
//                           ),
//                         )
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() => selectedType = value);
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // 🧾 Dropdown for Case Title
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: DropdownButton<String>(
//                     value: selectedTitle,
//                     isExpanded: true,
//                     underline: const SizedBox(),
//                     hint: const Text('Select Case Title'),
//                     items: caseTitles
//                         .map(
//                           (title) => DropdownMenuItem(
//                             value: title,
//                             child: Text(title),
//                           ),
//                         )
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() => selectedTitle = value);
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 // 🟦 Select Button
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.check_circle_outline, size: 20),
//                   label: const Text(
//                     'Select',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.blue[800],
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 4,
//                   ),
//                   onPressed: () {
//                     if (selectedType == null || selectedTitle == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Please select both fields.'),
//                         ),
//                       );
//                       return;
//                     }

//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                             'Selected: $selectedType → $selectedTitle'),
//                         backgroundColor: Colors.green.shade600,
//                       ),
//                     );
//                   },
//                 ),

//                 const SizedBox(height: 40),

//                 const Spacer(),
//                 const Icon(Icons.cases_rounded,
//                     color: Colors.white70, size: 100),
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

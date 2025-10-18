import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItRelatedDesignationPage extends StatefulWidget {
  const ItRelatedDesignationPage({super.key});

  @override
  State<ItRelatedDesignationPage> createState() =>
      _ItRelatedDesignationPageState();
}

class _ItRelatedDesignationPageState extends State<ItRelatedDesignationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ntnController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Get.snackbar(
  //                             'Success',
  //                             'Conversion completed successfully!',
  //                             snackPosition: SnackPosition.BOTTOM,
  //                             backgroundColor: Colors.green.shade100,
  //                           );
  //                           amountCtrl.clear();
  //                           noteCtrl.clear();
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Get.snackbar(
        'Success',
        '✅ Values submitted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.black87,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
        icon: const Icon(Icons.check_circle, color: Colors.green),
        duration: const Duration(seconds: 2),
      );

      // Clear fields after successful submission
      _nameController.clear();
      _ntnController.clear();
      _addressController.clear();
      _emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IT Related Designation'),
        // backgroundColor: const Color(0xFF0071BC),
      ),
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
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Applicant Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 🧍‍♂️ Applicant Name
                  _buildTextField(
                    controller: _nameController,
                    label: 'Applicant Name',
                    validator:
                        (v) =>
                            v == null || v.trim().isEmpty ? 'Enter name' : null,
                  ),

                  const SizedBox(height: 16),

                  // 🔢 NTN / CNIC
                  _buildTextField(
                    controller: _ntnController,
                    label: 'NTN / CNIC',
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Enter NTN or CNIC';
                      }
                      if (v.length < 5) {
                        return 'Invalid NTN/CNIC';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // 🏠 Address
                  _buildTextField(
                    controller: _addressController,
                    label: 'Applicant Address',
                    validator:
                        (v) =>
                            v == null || v.trim().isEmpty
                                ? 'Enter address'
                                : null,
                  ),

                  const SizedBox(height: 16),

                  // 📧 Email
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email ID',
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Enter email';
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(v)) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // ✅ Submit button
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send_rounded),
                    label: const Text('Submit', style: TextStyle(fontSize: 18)),
                    onPressed: _submitForm,
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
      ),
    );
  }

  /// 🔧 Helper widget for cleaner form fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label, border: InputBorder.none),
      ),
    );
  }
}

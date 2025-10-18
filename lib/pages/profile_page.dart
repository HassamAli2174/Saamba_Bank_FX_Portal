import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  final AuthController auth = Get.find();

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                (user.value != null && user.value!.isNotEmpty)
                    ? user.value!
                    : 'Hassam',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                (user.value != null && user.value!.isNotEmpty)
                    ? '${user.value}@email.com'
                    : 'hassam.ali@email.com',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.blueAccent),
              title: const Text('Account Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Colors.blueAccent),
              title: const Text('Privacy Policy'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  // Reactive variables for settings
  final darkMode = false.obs;
  final notificationsEnabled = true.obs;

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
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🧭 Header
                  // Row(
                  //   children: const [
                  //     Icon(Icons.settings, color: Colors.white, size: 32),
                  //     SizedBox(width: 10),
                  //     Text(
                  //       "Settings",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 26,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 20),

                  // ⚙️ Preferences Section
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Preferences',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // 🌙 Dark Mode toggle
                        SwitchListTile(
                          title: const Text('Dark Mode'),
                          subtitle: const Text('Switch app theme'),
                          value: darkMode.value,
                          activeColor: Colors.blueAccent,
                          onChanged: (val) {
                            darkMode.value = val;
                            Get.changeThemeMode(
                              val ? ThemeMode.dark : ThemeMode.light,
                            );
                          },
                        ),

                        // 🔔 Notifications toggle
                        SwitchListTile(
                          title: const Text('Enable Notifications'),
                          subtitle: const Text('Receive transaction alerts'),
                          value: notificationsEnabled.value,
                          activeColor: Colors.blueAccent,
                          onChanged: (val) {
                            notificationsEnabled.value = val;
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 👤 Account Section
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Account',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        ListTile(
                          leading: const Icon(
                            Icons.lock_outline,
                            color: Colors.blueAccent,
                          ),
                          title: const Text('Change Password'),
                          onTap: () {
                            Get.snackbar(
                              'Coming Soon',
                              'Password update feature coming soon',
                              backgroundColor: Colors.blue.shade100,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                        ),

                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: Colors.redAccent,
                          ),
                          title: const Text('Logout'),
                          onTap: () async {
                            final box = GetStorage();
                            await box.erase(); // clear login session
                            Get.offAllNamed('/login');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),

      // 📂 Drawer for consistency
      // drawer: const _SettingsDrawer(),
    );
  }
}

// class _SettingsDrawer extends StatelessWidget {
//   const _SettingsDrawer();

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF0071BC), Color(0xFF1DA1F2)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: const [
//                 Icon(Icons.settings, size: 64, color: Colors.white),
//                 SizedBox(width: 12),
//                 Text(
//                   'Settings',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home, color: Colors.blueAccent),
//             title: const Text('Home'),
//             onTap: () => Get.offNamed('/home'),
//           ),
//           ListTile(
//             leading: const Icon(Icons.currency_exchange, color: Colors.blueAccent),
//             title: const Text('Convert / Transfer'),
//             onTap: () => Get.toNamed('/convert'),
//           ),
//           ListTile(
//             leading: const Icon(Icons.history, color: Colors.blueAccent),
//             title: const Text('Transactions'),
//             onTap: () => Get.toNamed('/transaction'),
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.logout, color: Colors.redAccent),
//             title: const Text('Logout'),
//             onTap: () => Get.offAllNamed('/login'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SettingsPage extends StatelessWidget {
//   SettingsPage({super.key});

//   // You can use GetStorage or SharedPreferences later to persist settings.
//   final darkMode = false.obs;
//   final notificationsEnabled = true.obs;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: const Text('Settings'), centerTitle: true),
//       drawer: const _SettingsDrawer(), // ✅ Optional drawer for consistency
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Obx(
//           () => Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Preferences',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               const SizedBox(height: 12),

//               // Dark Mode toggle
//               SwitchListTile(
//                 title: const Text('Dark Mode'),
//                 subtitle: const Text('Switch app theme'),
//                 value: darkMode.value,
//                 onChanged: (val) {
//                   darkMode.value = val;
//                   Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light);
//                 },
//               ),

//               // Notifications toggle
//               SwitchListTile(
//                 title: const Text('Enable Notifications'),
//                 subtitle: const Text('Receive transaction alerts'),
//                 value: notificationsEnabled.value,
//                 onChanged: (val) {
//                   notificationsEnabled.value = val;
//                 },
//               ),

//               const Divider(height: 32),

//               const Text(
//                 'Account',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               const SizedBox(height: 12),

//               ListTile(
//                 leading: const Icon(Icons.lock_outline),
//                 title: const Text('Change Password'),
//                 onTap: () {
//                   Get.snackbar(
//                     'Coming soon',
//                     'Password update feature coming soon',
//                   );
//                 },
//               ),

//               ListTile(
//                 leading: const Icon(Icons.logout, color: Colors.redAccent),
//                 title: const Text('Logout'),
//                 onTap: () {
//                   Get.offAllNamed('/login');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _SettingsDrawer extends StatelessWidget {
//   const _SettingsDrawer();

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.blue.shade400, Colors.blue.shade800],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Row(
//               children: const [
//                 Icon(Icons.settings, size: 64, color: Colors.white),
//                 SizedBox(width: 12),
//                 Text(
//                   'Settings',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text('Home'),
//             onTap: () => Get.offNamed('/home'),
//           ),
//           ListTile(
//             leading: const Icon(Icons.currency_exchange),
//             title: const Text('Convert / Transfer'),
//             onTap: () => Get.toNamed('/convert'),
//           ),
//           ListTile(
//             leading: const Icon(Icons.history),
//             title: const Text('Transactions'),
//             onTap: () => Get.toNamed('/transaction'),
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.logout, color: Colors.redAccent),
//             title: const Text('Logout'),
//             onTap: () => Get.offAllNamed('/login'),
//           ),
//         ],
//       ),
//     );
//   }
// }

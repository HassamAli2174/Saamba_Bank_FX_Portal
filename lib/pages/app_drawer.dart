import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_nav_controller.dart';
import '../controllers/auth_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  void _goToTab(BuildContext context, int tabIndex) {
    Navigator.pop(context);

    if (tabIndex >= 0 && tabIndex <= 3) {
      if (Get.isRegistered<MainNavController>()) {
        final nav = Get.find<MainNavController>();
        nav.setIndex(tabIndex);

        if (Get.currentRoute != '/main') {
          Get.offAllNamed('/main');
        }
      } else {
        Get.offAllNamed('/main');
      }
    } else if (tabIndex == 4) {
      Get.toNamed('/profile');
    } else if (tabIndex == 5) {
      Get.toNamed('/rates');
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthController? auth =
        Get.isRegistered<AuthController>() ? Get.find<AuthController>() : null;

    final primary = Colors.blueAccent;

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.blue.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.account_circle,
                    size: 58,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 14),
                Text(
                  'Samba FX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/intotech_logo.png', // <-- your logo path
                  height: 45,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 6),
                const Text(
                  'InfoTech Groups',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          // 🔹 Drawer Options
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.home_rounded,
                  title: 'Home',
                  onTap: () => _goToTab(context, 0),
                ),
                _buildDrawerItem(
                  icon: Icons.currency_exchange_rounded,
                  title: 'Convert / Transfer',
                  onTap: () => _goToTab(context, 1),
                ),
                _buildDrawerItem(
                  icon: Icons.swap_horiz_rounded,
                  title: 'FX Cases',
                  onTap: () => _goToTab(context, 2),
                ),
                _buildDrawerItem(
                  icon: Icons.receipt_long_rounded,
                  title: 'All Transactions',
                  onTap: () => _goToTab(context, 3),
                ),
                const Divider(height: 30),
                _buildDrawerItem(
                  icon: Icons.person_outline_rounded,
                  title: 'Profile',
                  onTap: () => _goToTab(context, 4),
                ),
                _buildDrawerItem(
                  icon: Icons.show_chart_rounded,
                  title: 'FX Rates',
                  onTap: () => _goToTab(context, 5),
                ),
              ],
            ),
          ),

          // 🔻 Logout Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                if (auth != null) {
                  auth.logout();
                } else {
                  Get.offAllNamed('/login');
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.redAccent.withOpacity(0.2)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.logout, color: Colors.redAccent),
                    SizedBox(width: 10),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent, size: 26),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15.5,
          color: Colors.black87,
        ),
      ),
      horizontalTitleGap: 8,
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: Colors.blue.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/main_nav_controller.dart';
// import '../controllers/auth_controller.dart';

// class AppDrawer extends StatelessWidget {
//   const AppDrawer({Key? key}) : super(key: key);

//   void _goToTab(BuildContext context, int tabIndex) {
//     Navigator.pop(context); // close drawer

//     // Tabs 0–3 belong to BottomNavigationBar
//     if (tabIndex >= 0 && tabIndex <= 3) {
//       if (Get.isRegistered<MainNavController>()) {
//         final nav = Get.find<MainNavController>();
//         nav.setIndex(tabIndex);

//         // Make sure we're inside the main shell
//         if (Get.currentRoute != '/main') {
//           Get.offAllNamed('/main');
//         }
//       } else {
//         Get.offAllNamed('/main'); // fallback
//       }
//     }
//     // Profile and Settings are separate pages
//     else if (tabIndex == 4) {
//       Get.toNamed('/profile');
//     } else if (tabIndex == 5) {
//       Get.toNamed('/rates');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final AuthController? auth =
//         Get.isRegistered<AuthController>() ? Get.find<AuthController>() : null;

//     return Drawer(
//       child: Column(
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.blue.shade400, Colors.blue.shade800],
//               ),
//             ),
//             child: Row(
//               children: const [
//                 Icon(Icons.account_circle, size: 56, color: Colors.white),
//                 SizedBox(width: 12),
//                 Text(
//                   'Samba FX',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text('Home'),
//             onTap: () => _goToTab(context, 0),
//           ),

//           ListTile(
//             leading: const Icon(Icons.currency_exchange),
//             title: const Text('Convert / Transfer'),
//             onTap: () => _goToTab(context, 1),
//           ),
//           ListTile(
//             leading: const Icon(Icons.history),
//             title: const Text('FX Cases'),
//             onTap: () => _goToTab(context, 2),
//           ),
//           ListTile(
//             leading: const Icon(Icons.history),
//             title: const Text('All Transactions'),
//             onTap: () => _goToTab(context, 3),
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.person_outlined),
//             title: const Text('Profile'),
//             onTap: () => _goToTab(context, 4),
//           ),
//           ListTile(
//             leading: const Icon(Icons.show_chart),
//             title: const Text('FX Rates'),
//             onTap: () => _goToTab(context, 5),
//           ),
//           const Spacer(),
//           ListTile(
//             leading: const Icon(Icons.logout, color: Colors.redAccent),
//             title: const Text('Logout'),
//             onTap: () {
//               Navigator.pop(context);
//               if (auth != null) {
//                 auth.logout();
//               } else {
//                 Get.offAllNamed('/login');
//               }
//             },
//           ),
//           const SizedBox(height: 12),
//         ],
//       ),
//     );
//   }
// }

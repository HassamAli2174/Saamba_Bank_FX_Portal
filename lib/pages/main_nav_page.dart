// lib/pages/main_nav_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_nav_controller.dart';
import '../controllers/fx_controller.dart';
import '../controllers/auth_controller.dart';
import 'home_page.dart';
import 'convert_page.dart';
import 'transaction_page.dart';
import 'settings_page.dart';
import 'app_drawer.dart';
import 'fx_cases_page.dart';

class MainNavPage extends StatefulWidget {
  const MainNavPage({super.key});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage>
    with SingleTickerProviderStateMixin {
  final MainNavController nav = Get.find();
  final FXController fx = Get.find();
  final AuthController auth = Get.find();

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<Widget> _pages = [
    HomePage(),          // 0
    ConvertPage(),       // 1
    FXCasesPage(),       // 2 (center FAB)
    TransactionsPage(),  // 3
    SettingsPage(),      // 4
  ];

  final List<IconData> _visibleIcons = [
    Icons.home_rounded,         // page 0
    Icons.currency_exchange,    // page 1
    Icons.history_rounded,      // page 3
    Icons.settings_rounded,     // page 4
  ];

  @override
  void initState() {
    super.initState();

    // ⚡ Pulse animation controller
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation =
        Tween<double>(begin: 0.0, end: 8.0).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  int _visibleIndexToPageIndex(int visibleIndex) {
    if (visibleIndex < 2) return visibleIndex;
    return visibleIndex + 1;
  }

  String _getTitle(int idx) {
    switch (idx) {
      case 0:
        return 'My Accounts';
      case 1:
        return 'Convert / Transfer Funds';
      case 2:
        return 'FX Cases';
      case 3:
        return 'Transactions';
      case 4:
        return 'Settings';
      default:
        return 'Samba FX';
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Obx(() {
      final currentPage = nav.selectedIndex.value;

      return Scaffold(
        appBar: AppBar(title: Text(_getTitle(currentPage))),
        drawer: const AppDrawer(),
        body: _pages[currentPage],

        // 🌀 Center FAB with pulse animation
        floatingActionButton: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            final bool isActive = currentPage == 2;
            return Stack(
              alignment: Alignment.center,
              children: [
                if (isActive)
                  Container(
                    width: 72 + _pulseAnimation.value,
                    height: 72 + _pulseAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary.withOpacity(0.18),
                    ),
                  ),
                GestureDetector(
                  onTap: () => nav.setIndex(2),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    width: isActive ? 74 : 64,
                    height: isActive ? 74 : 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isActive
                          ? LinearGradient(
                              colors: [primary, primary.withOpacity(0.85)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: isActive ? null : Colors.white,
                      boxShadow: [
                        if (isActive)
                          BoxShadow(
                            color: primary.withOpacity(0.25),
                            blurRadius: 18,
                            spreadRadius: 4,
                          ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: isActive
                            ? primary.withOpacity(0.9)
                            : Color(0xFF1DA1F2),
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 250),
                        scale: isActive ? 1.05 : 1.0,
                        child: Icon(
                          Icons.cases_rounded,
                          size: 30,
                          color: isActive ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // 🧭 Custom bottom nav bar
        bottomNavigationBar: BottomAppBar(
          notchMargin: 8,
          shape: const CircularNotchedRectangle(),
          elevation: 10,
          color: Colors.white,
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // left two icons
                Row(
                  children: List.generate(2, (i) {
                    final pageIndex = _visibleIndexToPageIndex(i);
                    final bool isActive = currentPage == pageIndex;
                    return _buildNavItem(
                      icon: _visibleIcons[i],
                      label: i == 0 ? 'Home' : 'Convert',
                      active: isActive,
                      onTap: () => nav.setIndex(pageIndex),
                      activeColor: primary,
                    );
                  }),
                ),

                // right two icons
                Row(
                  children: List.generate(2, (j) {
                    final visibleIndex = j + 2;
                    final pageIndex = _visibleIndexToPageIndex(visibleIndex);
                    final bool isActive = currentPage == pageIndex;
                    return _buildNavItem(
                      icon: _visibleIcons[visibleIndex],
                      label:
                          visibleIndex == 2 ? 'Transactions' : 'Settings',
                      active: isActive,
                      onTap: () => nav.setIndex(pageIndex),
                      activeColor: primary,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool active,
    required VoidCallback onTap,
    required Color activeColor,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(active ? 6 : 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      active ? activeColor.withOpacity(0.12) : Colors.transparent,
                ),
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 220),
                  scale: active ? 1.12 : 1.0,
                  child: Icon(
                    icon,
                    size: 26,
                    color: active ? activeColor : Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // Text(
              //   label,
              //   style: TextStyle(
              //     fontSize: 10,
              //     color: active ? activeColor : Colors.grey.shade600,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/main_nav_controller.dart';
// import '../controllers/fx_controller.dart';
// import '../controllers/auth_controller.dart';
// import 'home_page.dart';
// import 'convert_page.dart';
// import 'transaction_page.dart';
// import 'settings_page.dart';
// import 'app_drawer.dart';
// import 'fx_cases_page.dart';

// class MainNavPage extends StatelessWidget {
//   MainNavPage({super.key});

//   final MainNavController nav = Get.find();
//   final FXController fx = Get.find();
//   final AuthController auth = Get.find();

//   final List<Widget> pages = [
//     HomePage(),
//     // FXRatesPage(),
//     ConvertPage(),
//     FXCasesPage(),
//     TransactionsPage(),
//     SettingsPage(),
//   ];

//   String _getTitle(int idx) {
//     switch (idx) {
//       case 0:
//         return 'My Accounts';
//       // case 1:
//       //   return 'FX Rates';
//       case 1:
//         return 'Convert / Transfer Funds';
//       case 2:
//         return 'FX Cases';
//       case 3:
//         return 'Transactions';
//       case 4:
//         return 'Settings';
//       default:
//         return 'Samba FX';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final idx = nav.selectedIndex.value;
//       return Scaffold(
//         appBar: AppBar(title: Text(_getTitle(idx))),
//         drawer: const AppDrawer(),
//         body: pages[idx],
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: idx,
//           onTap: nav.setIndex,
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: Theme.of(context).colorScheme.primary,
//           unselectedItemColor: Colors.grey,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             // BottomNavigationBarItem(
//             //   icon: Icon(Icons.show_chart),
//             //   label: 'Rates',
//             // ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.currency_exchange),
//               label: 'Convert',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.cases_rounded),
//               label: 'FX Cases',
//             ),

//             BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: 'Transactions',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'Settings',
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

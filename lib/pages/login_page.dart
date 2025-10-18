import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userCtrl = TextEditingController(text: 'Hassam');
  final TextEditingController passCtrl = TextEditingController(
    text: 'Hassam@123',
  );

  final AuthController auth = Get.find();

  void _login() {
    if (_formKey.currentState!.validate()) {
      final ok = auth.login(userCtrl.text.trim(), passCtrl.text.trim());
      if (ok) {
        Get.offAllNamed('/main');
      } else {
        Get.snackbar(
          'Login failed',
          'Invalid username or password.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade800,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🌟 Logo
                  Hero(
                    tag: 'logo',
                    child: Image.asset('assets/images/sambaa.png', height: 100),
                  ),
                  const SizedBox(height: 20),

                  // 🌟 Title
                  const Text(
                    'Welcome to SambaFX Portal',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 👤 Username
                  TextFormField(
                    controller: userCtrl,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // 🔒 Password
                  TextFormField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 28),

                  // 🚀 Login button
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 💡 Hint
                  const Text(
                    'Hint: username: Hassam | password: Hassam@123',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/auth_controller.dart';

// class LoginPage extends StatelessWidget {
//   final TextEditingController userCtrl = TextEditingController(text: 'Hassam');
//   final TextEditingController passCtrl = TextEditingController(text: 'Hassam@123');

//   final AuthController auth = Get.find();

//   LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey[50],
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // 🌟 Logo
//                 Hero(
//                   tag: 'logo',
//                   child: Image.asset(
//                     'assets/images/sambaa.png',
//                     height: 100,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // 🌟 Title
//                 const Text(
//                   'Welcome to SambaFX Portal',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueGrey,
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // 👤 Username
//                 TextField(
//                   controller: userCtrl,
//                   decoration: InputDecoration(
//                     labelText: 'Username',
//                     prefixIcon: const Icon(Icons.person_outline),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // 🔒 Password
//                 TextField(
//                   controller: passCtrl,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     prefixIcon: const Icon(Icons.lock_outline),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 28),

//                 // 🚀 Login button
//                 SizedBox(
//                   height: 48,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       final ok = auth.login(
//                         userCtrl.text.trim(),
//                         passCtrl.text.trim(),
//                       );

//                       if (ok) {
//                         // ✅ Navigate to main (home) page
//                         Get.offAllNamed('/main');
//                       } else {
//                         Get.snackbar(
//                           'Login failed',
//                           'Invalid credentials',
//                           snackPosition: SnackPosition.BOTTOM,
//                           backgroundColor: Colors.red.shade100,
//                           colorText: Colors.red.shade800,
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blueAccent,
//                       foregroundColor: Colors.white,
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // 💡 Hint
//                 const Text(
//                   'Hint: username: Hassam | password: Hassam@123',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey, fontSize: 13),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

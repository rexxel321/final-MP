import 'package:flutter/material.dart';
// Ganti 'flutter_application_1' dengan nama proyek Anda yang sebenarnya
import 'package:flutter_application_1/screens/SignUpScreen.dart'; 
import 'package:flutter_application_1/screens/main_tab_screen.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 1. Ikon Hati (Love Icon)
              const Icon(
                Icons.favorite_border,
                size: 80,
                color: Colors.black,
              ),
              const SizedBox(height: 10),

              // 2. Teks "Welcome Back"
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),

              // 3. Email/Username Input
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Email / Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                ),
              ),
              const SizedBox(height: 15),

              // 4. Password Input
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                ),
              ),
              const SizedBox(height: 5),

              // 5. Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Implementasi Forgot Password
                  },
                  child: const Text('Forgot Password?',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 15),

              // 6. Login Button (Navigasi ke MainTabScreen)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // NAVIGASI SETELAH LOGIN SUKSES
                    Navigator.pushReplacement( 
                      context,
                      MaterialPageRoute(
                        // Menggantikan LoginScreen dengan MainTabScreen
                        builder: (context) => const MainTabScreen(), 
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Background hitam
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Teks putih
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 7. OR Divider
              const Row(
                children: <Widget>[
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('or'),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),

              // 8. Continue with Google Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implementasi Google Sign-in
                  },
                  icon: Image.asset(
                    'assets/google_icon.png', 
                    height: 20.0,
                  ),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 9. Don't have an account? Sign Up (Navigasi ke SignUpScreen)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      // NAVIGASI KE SIGN UP SCREEN
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
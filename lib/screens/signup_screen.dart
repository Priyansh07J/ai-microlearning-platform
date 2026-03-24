import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'login_screen.dart';
import 'age_grade_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Back Button
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),

                const SizedBox(height: 20),

                // Title
                Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

                const SizedBox(height: 10),

                Text(
                  "Sign up to start learning",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 40),

                // Email Field
                const Text("Email"),
                const SizedBox(height: 8),
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                  ),
                ),

                const SizedBox(height: 20),

                // Password Field
                const Text("Password"),
                const SizedBox(height: 8),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                  ),
                ),

                const SizedBox(height: 20),

                // Confirm Password
                const Text("Confirm Password"),
                const SizedBox(height: 8),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Re-enter your password",
                  ),
                ),

                const SizedBox(height: 40),

                // Create Account Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AgeGradeScreen(),
                      ),
                    );
                  },
                  child: const Text("Create Account"),
                ),

                const SizedBox(height: 20),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF27EF9E), Color(0xFF0BB4E3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  "Create an account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                // Input fields
                _buildInputField("Enter Your Username"),
                const SizedBox(height: 20),
                _buildInputField("Enter Your Email"),
                const SizedBox(height: 20),
                _buildInputField("Enter Your Phone Number"),
                const SizedBox(height: 20),
                _buildInputField("Enter Your Password", isPassword: true),
                const SizedBox(height: 30),
                // Sign Up Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF27EF9E),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Handle sign-up functionality
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Divider
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.black26)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Or With"),
                    ),
                    Expanded(child: Divider(color: Colors.black26)),
                  ],
                ),
                const SizedBox(height: 20),
                // Google Sign-In Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black12),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      GoogleSignInAccount? account = await _googleSignIn.signIn();
                      if (account != null) {
                        print("Signed in as: ${account.displayName}");
                      }
                    } catch (error) {
                      print("Google Sign-In failed: $error");
                    }
                  },
                  icon: Image.asset(
                    'assets/google_logo.png',
                    height: 20,
                    width: 20,
                  ),
                  label: const Text(
                    "Sign up with Google",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                // Already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFF0BB4E3),
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
      ),
    );
  }

  Widget _buildInputField(String hintText, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
    );
  }
}

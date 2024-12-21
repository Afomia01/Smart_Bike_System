import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Successful!")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Failed: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Gradient Header
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF27EF9E), Color(0xFF0BB4E3)], // Updated gradient
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Welcome Message
            Text(
              "Hi, Welcome Back! 👋",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Email Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "example@gmail.com",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Password Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Enter Your Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Remember Me & Forgot Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Text("Remember Me"),
                    ],
                  ),
                  Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF27EF9E), // Same gradient color
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 15),

            // Or With Separator
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Or With"),
                ),
                Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 15),

            // Social Login Button (Google)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () => _handleGoogleSignIn(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(color: Colors.grey),
                ),
                icon: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                  height: 20,
                ),
                label: Text(
                  "Login with Google",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 15),

            // Don't Have an Account? Sign Up
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text.rich(
                TextSpan(
                  text: "Don’t have an account? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

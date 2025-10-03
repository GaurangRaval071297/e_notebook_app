import 'package:e_notebook_app/SharedPreference/SharePref.dart';
import 'package:e_notebook_app/Screens/Auth/Register/register_screen.dart';
import 'package:e_notebook_app/Screens/Dashboard/home.dart';
import 'package:e_notebook_app/DBHelper/DBHelper.dart';
import 'package:e_notebook_app/Widgets/Custom_Button/Custom_Button.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/Common_Textfields/common_textfields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController uEmail = TextEditingController();
  final TextEditingController uPass = TextEditingController();

  final dbHelper = DBHelper.instance;

  final RegExp emailRegEx =
  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  bool _obscurePassword = true;

  Future<void> loginUser() async {
    final email = uEmail.text.trim();
    final password = uPass.text.trim();

    // Check if user exists
    bool userExists = await dbHelper.checkUserExists(email);

    if (!userExists) {
      // User not registered
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not registered, please register first')),
      );
      return;
    }

    // Validate password
    bool isValid = await dbHelper.validateUser(email, password);

    if (isValid) {
      // Save login status
      await SharedPref.saveLoginStatus(true);
      await SharedPref.saveUserEmail(email); // Save email for future reference

      // Login successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      // Invalid password
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset('assets/logo1.png', height: 150),
                const SizedBox(height: 50),

                // Email Field
                CommonTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: uEmail,
                  hintText: 'Enter Email Address',
                  preFixIcon: const Icon(Icons.email),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    } else if (!emailRegEx.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  maxLine: 1,
                ),
                const SizedBox(height: 20),

                // Password Field with toggle icon
                CommonTextField(
                  obscureText: _obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  controller: uPass,
                  hintText: 'Enter Password',
                  sufFixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  maxLine: 1,
                ),
                const SizedBox(height: 20),

                // Login Button
                CustomButton(
                  buttonText: 'Login',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loginUser();
                    }
                  },
                ),
                const SizedBox(height: 20),

                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? Register",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: [
                                  Colors.blue.shade800,
                                  Colors.lightBlue.shade300,
                                ],
                              ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                          ),
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
}

import 'package:flutter/material.dart';
import 'package:my_new_app/screen/allforni.dart';
import 'package:my_new_app/screen/home_screen.dart';
import 'package:my_new_app/screen/forgot_password_screen.dart';
import 'package:my_new_app/service/loginservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:my_new_app/services/login_service.dart'; // Import your LoginService

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePass = true;

  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    String email = _emailController.text;
    String password = _passwordController.text;

    // Check for SQL Injection attempts
    if (_containsSqlInjection(email) || _containsSqlInjection(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid input detected.')),
      );
      return;
    }

    try {
      // Fetch user data from the remote API
      final response = await http.get(Uri.parse('http://192.168.1.106:8080/api/User/users'));

      if (response.statusCode == 200) {
        List<dynamic> users = json.decode(response.body);

        // Validate user credentials
        final user = users.firstWhere(
          (user) => user['email'] == email && user['password'] == password,
          orElse: () => null,
        );

        if (user != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);

          // Initialize the LoginService
          final loginService = LoginService();

          // Fetch and store data after successful login
          try {
            await loginService.loginAndFetchData();

            // After data is fetched and stored, navigate to the HomeScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } catch (e) {
            // Handle any errors during data fetch or storage
            print('Error fetching or storing data: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to fetch or store data. Please try again.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid email or password')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to connect to the server')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  bool _containsSqlInjection(String input) {
    final sqlInjectionPattern = RegExp(
        r"(?:')|(?:--)|(/\\*(?:.|[\\n\\r])*?\\*/)|(\b(select|update|delete|insert|exec|drop|grant|alter|create|truncate|backup)\b)");
    return sqlInjectionPattern.hasMatch(input.toLowerCase());
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailPattern.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    ColorScheme ct = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: mq.height * 0.14),
                    child: Container(
                      height: 104,
                      width: 104,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/Group 9.png'))),
                    )),
                const SizedBox(height: 8),
                const Text(
                  'PMSControl',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Please Login to continue to the home page',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Your Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: _passwordController,
                  obscureText: hidePass,
                  decoration: InputDecoration(
                    labelText: 'Your Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(hidePass
                          ? Icons.visibility_off
                          : Icons.visibility_outlined),
                      onPressed: () {
                        setState(() {
                          hidePass = !hidePass;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () => _login(context),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 12)),
                              backgroundColor:
                                  MaterialStateProperty.all(ct.secondary),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "Login",
                              style: tt.bodyMedium,
                            ),
                          ))),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AllSupplierScreen()),
                            );
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 12)),
                              backgroundColor:
                                  MaterialStateProperty.all(ct.secondary),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "Home Page",
                              style: tt.bodyMedium,
                            ),
                          ))),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

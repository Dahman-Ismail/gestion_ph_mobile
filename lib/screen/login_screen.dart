import 'package:flutter/material.dart';
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userIP = prefs.getString('userIP');

      // Fetch user
      String url = 'http://$userIP:8080/api/User/users';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> users = json.decode(response.body);

        // Validate user credentials
        final user = users.firstWhere(
          (user) => user['email'] == email && user['password'] == password,
          orElse: () => null,
        );

        if (user != null) {
          // Check if the user's roleid is 1
          if (user['RoleId'] == 1) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', true);

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
                const SnackBar(
                    content: Text(
                        'Failed to fetch or store data. Please try again.')),
              );
            }
          } else {
            // User exists but roleid is not 1
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Access denied. Incorrect role.')),
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
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your Email',
                      labelStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: _passwordController,
                  obscureText: hidePass,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Your Password',
                    labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
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
                              padding: WidgetStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 12)),
                              backgroundColor:
                                  WidgetStateProperty.all(ct.secondary),
                              shape: WidgetStateProperty.all(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

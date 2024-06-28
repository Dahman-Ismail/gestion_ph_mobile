// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:my_new_app/db/DAO/user_dao.dart';
import 'package:my_new_app/model/Users.dart';
import 'package:my_new_app/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserDao _userDao = UserDao();

  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    String email = _emailController.text;
    String password = _passwordController.text;
    if (_containsSqlInjection(email) || _containsSqlInjection(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid input detected.')),
      );
      return;
    }
    User? user = await _userDao.getUserByEmail(email);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not found')),
      );
      return;
    }
    bool isValidUser = await _userDao.validateUser(email, password);

    if (isValidUser) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
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

  bool hidePass = true;

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
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          },
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

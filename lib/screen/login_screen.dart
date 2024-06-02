import 'package:flutter/material.dart';
import 'package:my_new_app/db/DAO/user_dao.dart';
import 'package:my_new_app/model/Users.dart';
import 'package:my_new_app/screen/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
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
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid email or password')),
    );
  }
}


  bool _containsSqlInjection(String input) {
    final sqlInjectionPattern = RegExp(r"(?:')|(?:--)|(/\\*(?:.|[\\n\\r])*?\\*/)|(\b(select|update|delete|insert|exec|drop|grant|alter|create|truncate|backup)\b)");
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png'), // Add your logo asset
              const SizedBox(height: 20),
              const Text(
                'PMSControl',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'Login To Continue',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Your Email',
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Your Password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                    );
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _login(context),
                  child: const Text('Login'),
                ),
              ),
              
              
              
              
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  child: const Text('Login 2'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_new_app/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IPPage extends StatefulWidget {
  const IPPage({super.key});

  @override
  _IPPageState createState() => _IPPageState();
}

class _IPPageState extends State<IPPage> {
  final TextEditingController _ipController = TextEditingController();
  String _storedIP = "";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadSavedIP();
  }

  // Load saved IP address from shared preferences
  Future<void> _loadSavedIP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedIP = prefs.getString('userIP') ?? '';
      _ipController.text = _storedIP;
    });
  }

  // Save the current IP address to shared preferences
  Future<void> _saveIP() async {
    if (_formKey.currentState?.validate() ?? false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userIP', _ipController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('IP Address saved!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  // Remove the saved IP address from shared preferences
  Future<void> _deleteIP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userIP');
    setState(() {
      _ipController.text = '';
      _storedIP = '';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('IP Address deleted!')),
    );
  }

  String? _validateIP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an IP address';
    }

    final ipPattern =
        r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$';
    final regExp = RegExp(ipPattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid IPv4 address';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme ct = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save IP Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _ipController,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'IP Address',
                    labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 221, 186, 186))),
                validator: _validateIP,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _saveIP, // Call _logout function
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 148),
                      ),
                      backgroundColor: MaterialStateProperty.all(ct.primary),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          color: ct.surface,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            "Save",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
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

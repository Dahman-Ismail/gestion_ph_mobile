import 'package:flutter/material.dart';
import 'package:my_new_app/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:network_info_plus/network_info_plus.dart';

class IPPage extends StatefulWidget {
  @override
  _IPPageState createState() => _IPPageState();
}

class _IPPageState extends State<IPPage> {
  final TextEditingController _ipController = TextEditingController();
  String _storedIP = "";

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

  // Fetch local IP address using network_info_plus
  // Future<void> _fetchLocalIPAddress() async {
  //   final info = NetworkInfo();
  //   String? localIP = await info.getWifiIP(); // Get the local IPv4 address

  //   setState(() {
  //     _ipController.text = localIP ?? 'Failed to get IP address';
  //   });
  // }

  // Save the current IP address to shared preferences
  Future<void> _saveIP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userIP', _ipController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('IP Address saved!')),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
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
      SnackBar(content: Text('IP Address deleted!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save IP Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _ipController,
              decoration: InputDecoration(
                labelText: 'IP Address',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _saveIP,
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: _deleteIP,
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

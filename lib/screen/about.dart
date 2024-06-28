import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Pharmacy Management System',
              style: TextStyle(
                fontSize: 28, // Size for a headline-like text
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Manage your pharmacy efficiently with our comprehensive system.',
              style: TextStyle(
                fontSize: 16, // Size for a body text
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            
            // Mobile App Features
            const Text(
              'Mobile App Features',
              style: TextStyle(
                fontSize: 24, // Size for a subheading-like text
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '- Easy-to-use interface\n'
              '- Real-time inventory management\n'
              '- Sales and customer management\n'
              '- Integrated with desktop application\n',
              style: TextStyle(
                fontSize: 16, // Size for a list or paragraph text
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            
            // Desktop App Section
            const Text(
              'Desktop Application',
              style: TextStyle(
                fontSize: 24, // Size for a subheading-like text
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Our desktop application provides robust and advanced features for larger screens.',
              style: TextStyle(
                fontSize: 16, // Size for a body text
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Image.asset(
                'assets/logo.png',
                height: 200, // Adjust the height as needed
              ),
            ),
            const SizedBox(height: 20),
            
            // Footer
            const Text(
              'For more information, visit our website or contact support.',
              style: TextStyle(
                fontSize: 16, // Size for a body text
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

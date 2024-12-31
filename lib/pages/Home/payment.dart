import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Asset 1.png',
          fit: BoxFit.contain,
          height: 50, // Adjust logo size as needed
        ),
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF0BB4E3), // Reverse the gradient colors
                Color(0xFF27EF9E),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Card Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Illustration (replace with your asset)
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.teal[100],
                      ),
                      child: Icon(Icons.directions_bike,
                          size: 40, color: Colors.teal),
                    ),
                    SizedBox(width: 16),
                    // Payment Amount
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '10.50 Birr',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Add payment action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Pay'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Payment Options Section
            Text(
              'Payment Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Telebirr Option
            ListTile(
              onTap: () {
                // Navigate to Telebirr payment
              },
              leading: Icon(Icons.mobile_friendly, color: Colors.teal),
              title: Text('Pay with Telebirr'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            Divider(),

            // M-Pesa Option
            ListTile(
              onTap: () {
                // Navigate to M-Pesa payment
              },
              leading: Icon(Icons.payment, color: Colors.orange),
              title: Text('Pay with M-Pesa'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}

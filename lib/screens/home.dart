import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/providers/api.dart';
import 'package:flutter_task/screens/verify_otp.dart';
import 'package:flutter_task/widgets/app_test.dart';

class MyHomePage extends StatefulWidget {
  final String? device_id;
  final String? userId;

  const MyHomePage({super.key, this.device_id, this.userId});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _mobileNumberController = TextEditingController();
  final Api _api = Api();
  int _selectedIndex = 0;

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Result'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSendOtp() async {
    final mobileNumber = _mobileNumberController.text.trim();
    if (mobileNumber.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => Center(child: CircularProgressIndicator()),
      );

      try {
        final response = await _api.sendOtpRequest(mobileNumber);
        Navigator.of(context).pop(); // Close loading dialog

        if (response['success']) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerificationPage(
                deviceid1: widget.device_id ?? '',
                userid1: response['userId']?.toString() ?? '',
                onSubmit: (String) {},
              ),
            ),
          );
        } else {
          _showDialog(response['message'] ?? 'An error occurred.');
        }
      } catch (e) {
        Navigator.of(context).pop(); // Close loading dialog
        _showDialog('Failed to send OTP. Please try again later.');
        print('Error: $e');
      }
    } else {
      _showDialog('Please enter a mobile number.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Send OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight / 5,
              width: screenWidth,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/logo2.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Row(
                    children: List.generate(2, (index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: _selectedIndex == index
                                  ? Colors.red
                                  : Colors.white,
                              borderRadius: BorderRadius.horizontal(
                                left: index == 0 ? Radius.circular(10.0) : Radius.zero,
                                right: index == 1 ? Radius.circular(10.0) : Radius.zero,
                              ),
                              border: Border.all(
                                color: _selectedIndex == index ? Colors.red : Colors.transparent,
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                index == 0 ? 'Phone' : 'Email',
                                style: TextStyle(
                                  color: _selectedIndex == index ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              AppStrings.Glad,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              AppStrings.pls_provide,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: _mobileNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(300, 50)),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                backgroundColor: MaterialStateProperty.all(Colors.red), // Changed color for better visibility
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: _handleSendOtp,
              child: Text(
                'SEND CODE',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

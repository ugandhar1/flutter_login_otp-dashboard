import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_task/providers/api.dart';
import 'package:flutter_task/screens/register_page.dart';// Ensure SendReferralPage is imported
import 'package:flutter_task/widgets/app_test.dart'; // Ensure AppStrings is imported

class OtpVerificationPage extends StatefulWidget {
  final String deviceid1;
  final String userid1;
  final Function(String) onSubmit;

  const OtpVerificationPage({
    Key? key,
    required this.deviceid1,
    required this.userid1,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _focusNodes = List.generate(4, (_) => FocusNode());
  final _controllers = List.generate(4, (_) => TextEditingController());
  late Timer _timer;
  int _start = 60; // Countdown time in seconds

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
    if (_controllers.every((controller) => controller.text.length == 1)) {
      widget.onSubmit(_controllers.map((c) => c.text).join());
    }
  }

  Future<void> _verifyOtp() async {
    final otp = _controllers.map((c) => c.text).join();
    if (otp.isNotEmpty) {
      try {
        await Api().verifyOtp(otp, widget.deviceid1, widget.userid1);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SendReferralPage(userid: widget.userid1),
          ),
        );
      } catch (e) {
        _showDialog('OTP verification failed. Please try again.');
      }
    } else {
      _showDialog('Please enter the OTP.');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight / 5,
              width: screenWidth,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/message.PNG'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            const Text(
              AppStrings.otp,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(AppStrings.Community1, style: TextStyle(fontSize: 15)),
            const SizedBox(height:10),
            const Text(AppStrings.Community2),
             SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 50,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _onChanged(value, index),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("$_start seconds remaining"),
                     ElevatedButton(
              onPressed: _verifyOtp,
              child: Text('SEND AGAIN'),
            ),
                  ],
                ),
              ],
            ),
            
           
          ],
        ),
      ),
    );
  }
}

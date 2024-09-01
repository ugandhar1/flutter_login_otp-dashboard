import 'package:flutter/material.dart';
import 'package:flutter_task/providers/api.dart';
import 'package:flutter_task/screens/dash_board_page.dart';
import 'package:flutter_task/widgets/app_test.dart'; // Ensure correct import
 // Import your dashboard page

class SendReferralPage extends StatefulWidget {
  final String? userid;

  const SendReferralPage({super.key, this.userid});

  @override
  _SendReferralPageState createState() => _SendReferralPageState();
}

class _SendReferralPageState extends State<SendReferralPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final Api api = Api();

  void _showDialog(String message, {bool shouldNavigate = false}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Result'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (shouldNavigate) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Dashboard ()),
                );
              }
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendReferral() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final userId = widget.userid;

    if (email.isNotEmpty && password.isNotEmpty && userId != null && userId.isNotEmpty) {
      final response = await api.sendReferralEmail(email, password, userId);

      if (response['success']) {
        _showDialog(response['message'], shouldNavigate: true);
      } else {
        _showDialog(response['message']);
      }
    } else {
      _showDialog('Please fill in all fields correctly.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Send Referral Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight / 5,
              width: screenWidth,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/logo2.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              AppStrings.lets_begin,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(AppStrings.community3, style: TextStyle(fontSize: 15)),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.password_sharp),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _sendReferral,
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

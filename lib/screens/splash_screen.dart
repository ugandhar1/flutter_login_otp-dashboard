import 'package:flutter/material.dart';
import 'package:flutter_task/providers/api.dart';
import 'package:flutter_task/screens/home.dart';

class SplashScreen extends StatefulWidget {
  final String? device_id;

  const SplashScreen({super.key, this.device_id});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _performStartupTasks();
  }

  Future<void> _performStartupTasks() async {
    try {
      print('Starting API request');
      Api api = Api();
      await api.sendDeviceInfo(widget.device_id); // Ensure this is awaited
      print('API request completed');

      // Navigate to the home screen after splash
      if (mounted) { // Check if the widget is still in the widget tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              device_id: widget.device_id,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error occurred: $e'); // Handle error properly in production
      // You can navigate to an error screen or show a message here
    }
  }

  @override
  Widget build(BuildContext context) {
    // Screen height and width
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/flash.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

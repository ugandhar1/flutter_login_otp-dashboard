import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<void> sendDeviceInfo(String? deviceId) async {
    final url = Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/device/add');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'deviceId': deviceId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print(response.body);
        print(response.statusCode);
        // Handle success
        print('Device info sent successfully');
      } else {
        // Handle error
        print('Failed to send device info: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Error occurred: $e');
    }
  }
  final String _apiUrl = 'http://devapiv4.dealsdray.com/api/v2/user/otp';

  Future<Map<String, dynamic>> sendOtpRequest(String mobileNumber) async {
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({"mobileNumber": mobileNumber});
    final uri = Uri.parse(_apiUrl);

    try {
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        print(response.body);
        final data = json.decode(response.body);
        if (data['status'] == 1) {
          // Return userId and deviceId on success
          return {
            'success': true,
            'userId': data['data']['userId'],
            'deviceId': data['data']['deviceId'],
          };
        } else {
          // Return error message if status is not 1
          return {
            'success': false,
            'message': data['data']['message'],
          };
        }
      } else {
        // Handle HTTP errors
        return {
          'success': false,
          'message': 'Failed to send OTP: ${response.reasonPhrase}',
        };
      }
    } catch (e) {
      // Handle exceptions
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  
}

Future<void> verifyOtp(String otp,String device,String user) async {
  var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp/verification'));
request.body = json.encode({
  "otp": otp,
  "deviceId":device,
  "userId": user,
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(response.statusCode);
 
}
else {
  print(response.reasonPhrase);
}

  }

final String _apiUrl2 = 'http://devapiv4.dealsdray.com/api/v2/user/email/referral';

  Future<Map<String, dynamic>> sendReferralEmail(String email, String password, String userId) async {
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "email": email,
      "password": password,
      "userId": userId,
    });

    try {
      final response = await http.post(Uri.parse(_apiUrl2), headers: headers, body: body);

      if (response.statusCode == 200) {
        print(response.body);
        final responseBody = json.decode(response.body);

        if (responseBody is Map<String, dynamic> && responseBody.containsKey('status')) {
          if (responseBody['status'] == 1) {
            return {'success': true, 'message': responseBody['data']['message']};
          } else {
            return {'success': false, 'message': responseBody['data']['message'] ?? 'Unknown error occurred'};
          }
        } else {
          return {'success': false, 'message': 'Unexpected response format'};
        }
      } else {
        return {'success': false, 'message': 'Failed to send referral email: ${response.reasonPhrase}'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

}
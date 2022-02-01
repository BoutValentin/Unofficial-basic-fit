import 'dart:convert';
import 'dart:io';

import 'package:basicfitsmartbooking/Constants/api_urls.dart';
import 'package:basicfitsmartbooking/Constants/api_utils.dart';
import 'package:basicfitsmartbooking/Models/user.dart';
import 'package:basicfitsmartbooking/Requests/my_cookies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final cookieLogProvider = StateProvider<MyCookies>((ref) {
  return MyCookies();
});
final userLogProvider = StateProvider<User?>((ref) {
  return null;
});

class LogRequest {
  Future<User?> login(String email, String pwd, dynamic ref) async {
    http.Response response = await http.post(
        Uri.parse("$basicFitApi/authentication/login"),
        headers: headers,
        body: {"cardNumber": "", "email": email, "password": pwd});
    if (response.statusCode > 200) {
      return null;
    }
    final rJson = json.decode(response.body);
    final myCookies = ref.read(cookieLogProvider);
    myCookies.parse(response.headers['set-cookie'] ?? '');

    rJson['member']['pwd'] = pwd;
    return User.fromMap(rJson['member']);
  }
}

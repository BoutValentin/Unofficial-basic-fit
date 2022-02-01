import 'dart:convert';
import 'package:basicfitsmartbooking/Constants/api_urls.dart';
import 'package:basicfitsmartbooking/Constants/api_utils.dart';
import 'package:basicfitsmartbooking/Models/clubs.dart';
import 'package:basicfitsmartbooking/Requests/log_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ClubRequest {
  Future<Clubs> getAllClubs(String cookies, dynamic ref) async {
    final response = await http.get(
        Uri.parse("$basicFitApi/door-policy/get-clubs"),
        headers: {...headers, 'Cookie': cookies});
    if (response.statusCode > 200) {
      return Clubs(clubs: []);
    }
    final rJson = json.decode(response.body);
    final myCookies = ref.read(cookieLogProvider);
    myCookies.parse(response.headers['set-cookie'] ?? '');

    return Clubs.fromMap({'clubs': rJson});
  }
}

final clubRequestProvider = FutureProvider<Clubs>((ref) async {
  final cookie = ref.read(cookieLogProvider);
  return ClubRequest().getAllClubs(cookie.cookiesString(), ref);
});

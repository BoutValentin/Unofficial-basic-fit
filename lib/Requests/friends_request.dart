import 'dart:convert';

import 'package:basicfitsmartbooking/Constants/api_urls.dart';
import 'package:basicfitsmartbooking/Constants/api_utils.dart';
import 'package:basicfitsmartbooking/Models/friend.dart';
import 'package:basicfitsmartbooking/Models/user.dart';
import 'package:basicfitsmartbooking/Requests/log_request.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendsRequest {
  Future<List<Friend>> getFriends(String cookie, dynamic ref) async {
    final response = await http.get(
        Uri.parse("$basicFitApi/friends/get-friends"),
        headers: {...headers, 'Cookie': cookie});

    if (response.statusCode > 200) {
      return [];
    }
    var rJson = json.decode(response.body);
    final myCookies = ref.read(cookieLogProvider);
    myCookies.parse(response.headers['set-cookie'] ?? '');
    rJson = {'friends': rJson};
    return rJson['friends']?.map<Friend>((x) => Friend.fromMap(x)).toList() ??
        [];
  }
}

final friendRequestProvider = FutureProvider<List<Friend>>((ref) async {
  final cookie = ref.read(cookieLogProvider);
  return FriendsRequest().getFriends(cookie.cookiesString(), ref);
});

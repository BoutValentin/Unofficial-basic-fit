import 'dart:convert';

import 'package:basicfitsmartbooking/Constants/api_urls.dart';
import 'package:basicfitsmartbooking/Constants/api_utils.dart';
import 'package:basicfitsmartbooking/Models/booking.dart';
import 'package:basicfitsmartbooking/Requests/friends_request.dart';
import 'package:basicfitsmartbooking/Requests/log_request.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class CurrentBookingRequest {
  Future<List<Booking>> getBooking(String cookie, dynamic ref) async {
    final response = await http.get(
        Uri.parse("$basicFitApi/door-policy/get-open-reservation"),
        headers: {...headers, 'Cookie': cookie});
    if (response.statusCode > 200) {
      throw Exception("Error loading");
    }
    final rJson = json.decode(response.body);
    final myCookies = ref.read(cookieLogProvider);
    myCookies.parse(response.headers['set-cookie'] ?? '');
    final friends = await ref.read(friendRequestProvider.future);
    for (var d in rJson['data']) {
      dynamic lst = [];
      for (String e in d['friends']) {
        for (var friend in friends) {
          if (friend.id_g.toLowerCase() == e.toLowerCase()) {
            lst.add(friend.toMap());
          }
        }
      }
      d['friends'] = lst;
    }
    List<Booking> klst =
        rJson['data']?.map<Booking>((e) => Booking.fromMap(e)).toList() ?? [];
    return klst;
  }
}

final currentBookingProvider = FutureProvider<List<Booking>>((ref) async {
  final cookie = ref.read(cookieLogProvider);
  return CurrentBookingRequest().getBooking(cookie.cookiesString(), ref);
});

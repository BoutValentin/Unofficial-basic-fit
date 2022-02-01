import 'dart:convert';
import 'dart:io';

import 'package:basicfitsmartbooking/Constants/api_urls.dart';
import 'package:basicfitsmartbooking/Constants/api_utils.dart';
import 'package:basicfitsmartbooking/Models/club.dart';
import 'package:basicfitsmartbooking/Models/friend.dart';
import 'package:http/http.dart' as http;

class BookTrainingRequest {
  Future<dynamic> getDisponibility(
      String clubId, String dateTime, String cookies) async {
    final response = await http
        .post(Uri.parse("$basicFitApi/door-policy/get-availability"), headers: {
      ...headers,
      'Cookie': cookies
    }, body: {
      "clubId": clubId,
      "dateTime": dateTime,
    });
    if (response.statusCode == 204) {
      return json.decode('{"error": "no more booking available"}');
    }
    return json.decode(response.body);
  }

  Future<dynamic> bookTraining(
      {required dynamic doorPolicy,
      required String duration,
      required Club club,
      required String cookies,
      Friend? friend}) async {
    final response = await http.post(
        Uri.parse("$basicFitApi/door-policy/book-door-policy"),
        headers: {
          ...headers,
          'Cookie': cookies,
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: json.encode({
          "doorPolicy": doorPolicy,
          "duration": duration,
          "clubOfChoice": club.toMap(),
          "friend": friend?.toMap()
        }));
    print(response.body);
    return json.decode(response.body);
  }

  Future<dynamic> removeTraining(
      String doorPolicyPeopleId, String cookies) async {
    final response = await http.post(
        Uri.parse("$basicFitApi/door-policy/cancel-door-policy"),
        headers: {
          ...headers,
          'Cookie': cookies,
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: json.encode({"doorPolicyPeopleId": doorPolicyPeopleId}));
    print(response.body);
    return json.decode(response.body);
  }
}

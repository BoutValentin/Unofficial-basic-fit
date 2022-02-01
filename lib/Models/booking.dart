import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:basicfitsmartbooking/Models/friend.dart';

class Booking {
  String doorPolicyPeopleId;
  String startDateTime;
  String endDateTime;
  String created;
  String clubId;
  String clubName;
  String clubCity;
  List<Friend> friends;
  int duration;
  Booking({
    required this.doorPolicyPeopleId,
    required this.startDateTime,
    required this.endDateTime,
    required this.created,
    required this.clubId,
    required this.clubName,
    required this.clubCity,
    required this.friends,
    required this.duration,
  });

  Booking copyWith({
    String? doorPolicyPeopleId,
    String? startDateTime,
    String? endDateTime,
    String? created,
    String? clubId,
    String? clubName,
    String? clubCity,
    List<Friend>? friends,
    int? duration,
  }) {
    return Booking(
      doorPolicyPeopleId: doorPolicyPeopleId ?? this.doorPolicyPeopleId,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      created: created ?? this.created,
      clubId: clubId ?? this.clubId,
      clubName: clubName ?? this.clubName,
      clubCity: clubCity ?? this.clubCity,
      friends: friends ?? this.friends,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doorPolicyPeopleId': doorPolicyPeopleId,
      'startDateTime': startDateTime,
      'endDateTime': endDateTime,
      'created': created,
      'clubId': clubId,
      'clubName': clubName,
      'clubCity': clubCity,
      'friends': friends.map((x) => x.toMap()).toList(),
      'duration': duration,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      doorPolicyPeopleId: map['doorPolicyPeopleId'] ?? '',
      startDateTime: map['startDateTime'] ?? '',
      endDateTime: map['endDateTime'] ?? '',
      created: map['created'] ?? '',
      clubId: map['clubId'] ?? '',
      clubName: map['clubName'] ?? '',
      clubCity: map['clubCity'] ?? '',
      friends: List<Friend>.from(map['friends']?.map((x) => Friend.fromMap(x))),
      duration: map['duration']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Booking(doorPolicyPeopleId: $doorPolicyPeopleId, startDateTime: $startDateTime, endDateTime: $endDateTime, created: $created, clubId: $clubId, clubName: $clubName, clubCity: $clubCity, friends: $friends, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Booking &&
        other.doorPolicyPeopleId == doorPolicyPeopleId &&
        other.startDateTime == startDateTime &&
        other.endDateTime == endDateTime &&
        other.created == created &&
        other.clubId == clubId &&
        other.clubName == clubName &&
        other.clubCity == clubCity &&
        listEquals(other.friends, friends) &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return doorPolicyPeopleId.hashCode ^
        startDateTime.hashCode ^
        endDateTime.hashCode ^
        created.hashCode ^
        clubId.hashCode ^
        clubName.hashCode ^
        clubCity.hashCode ^
        friends.hashCode ^
        duration.hashCode;
  }
}

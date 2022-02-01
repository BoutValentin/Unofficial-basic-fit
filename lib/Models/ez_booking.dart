import 'dart:convert';

import 'package:basicfitsmartbooking/Models/club.dart';

class EzBooking {
  final int id;
  final String name;
  final String hour;
  final String duration;
  final String assets;
  final Club club;
  EzBooking(
      {required this.id,
      required this.name,
      required this.hour,
      required this.club,
      required this.duration,
      required this.assets});

  EzBooking copyWith({
    int? id,
    String? name,
    String? hour,
    String? duration,
    String? assets,
    Club? club,
  }) {
    return EzBooking(
      id: id ?? this.id,
      name: name ?? this.name,
      hour: hour ?? this.hour,
      assets: assets ?? this.assets,
      duration: duration ?? this.duration,
      club: club ?? this.club,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'hour': hour,
      'duration': duration,
      'assets': assets,
      'club': club.toMap(),
    };
  }

  factory EzBooking.fromMap(Map<String, dynamic> map) {
    return EzBooking(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      hour: map['hour'] ?? '',
      assets: map['assets'] ?? '',
      duration: map['duration'] ?? '',
      club: Club.fromMap(map['club']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EzBooking.fromJson(String source) =>
      EzBooking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EzBooking(id: $id, name: $name, assets: $assets, hour: $hour, club: $club)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EzBooking &&
        other.id == id &&
        other.name == name &&
        other.hour == hour &&
        other.assets == assets &&
        other.club == club;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        hour.hashCode ^
        club.hashCode ^
        assets.hashCode;
  }

  int getHourOfHour() {
    return int.parse(hour.split('h')[0]);
  }

  int getMinutesOfHour() {
    return int.parse(hour.split('h')[1]);
  }
}

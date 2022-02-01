import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:basicfitsmartbooking/Models/club.dart';

class Clubs {
  final List<Club> clubs;
  Clubs({
    required this.clubs,
  });

  Clubs copyWith({
    List<Club>? clubs,
  }) {
    return Clubs(
      clubs: clubs ?? this.clubs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clubs': clubs.map((x) => x.toMap()).toList(),
    };
  }

  factory Clubs.fromMap(Map<String, dynamic> map) {
    return Clubs(
      clubs: List<Club>.from(map['clubs']?.map((x) => Club.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Clubs.fromJson(String source) => Clubs.fromMap(json.decode(source));

  @override
  String toString() => 'Clubs(clubs: $clubs)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Clubs && listEquals(other.clubs, clubs);
  }

  @override
  int get hashCode => clubs.hashCode;

  List<Club> search(String str) {
    List<Club> clubs = [];
    for (final club in this.clubs) {
      if (club.name.toLowerCase().contains(str)) clubs.add(club);
    }
    return clubs;
  }
}

import 'dart:convert';

class Club {
  final String name;
  final String id;
  final String country;
  final bool bookable;
  final String status;
  final bool debt_check;
  final String label_name;
  final double longitude;
  final double latitude;
  Club({
    required this.name,
    required this.id,
    required this.country,
    required this.bookable,
    required this.status,
    required this.debt_check,
    required this.label_name,
    required this.longitude,
    required this.latitude,
  });

  Club copyWith({
    String? name,
    String? id,
    String? country,
    bool? bookable,
    String? status,
    bool? debt_check,
    String? label_name,
    double? longitude,
    double? latitude,
  }) {
    return Club(
      name: name ?? this.name,
      id: id ?? this.id,
      country: country ?? this.country,
      bookable: bookable ?? this.bookable,
      status: status ?? this.status,
      debt_check: debt_check ?? this.debt_check,
      label_name: label_name ?? this.label_name,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'country': country,
      'bookable': bookable,
      'status': status,
      'debt_check': debt_check,
      'label_name': label_name,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory Club.fromMap(Map<String, dynamic> map) {
    return Club(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      country: map['country'] ?? '',
      bookable: map['bookable'] ?? false,
      status: map['status'] ?? '',
      debt_check: map['debt_check'] ?? false,
      label_name: map['label_name'] ?? '',
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Club.fromJson(String source) => Club.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Club(name: $name, id: $id, country: $country, bookable: $bookable, status: $status, debt_check: $debt_check, label_name: $label_name, longitude: $longitude, latitude: $latitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Club &&
        other.name == name &&
        other.id == id &&
        other.country == country &&
        other.bookable == bookable &&
        other.status == status &&
        other.debt_check == debt_check &&
        other.label_name == label_name &&
        other.longitude == longitude &&
        other.latitude == latitude;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        country.hashCode ^
        bookable.hashCode ^
        status.hashCode ^
        debt_check.hashCode ^
        label_name.hashCode ^
        longitude.hashCode ^
        latitude.hashCode;
  }
}

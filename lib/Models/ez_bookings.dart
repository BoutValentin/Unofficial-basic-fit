import 'dart:convert';

import 'package:basicfitsmartbooking/Navigation/simple_nav.dart';
import 'package:flutter/foundation.dart';

import 'package:basicfitsmartbooking/Models/ez_booking.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EzBookings extends StateNotifier<List<EzBooking>> {
  bool error = false;
  bool load = false;
  EzBookings() : super([]);
  EzBookings.data(List<EzBooking> ls) : super(ls);

  EzBookings.error() : super([]) {
    error = true;
  }

  EzBookings.load() : super([]) {
    load = true;
  }

  Map<String, dynamic> toMap() {
    return {
      'bookings': state.map((x) => x.toMap()).toList(),
    };
  }

  factory EzBookings.fromMap(Map<String, dynamic> map) {
    return EzBookings.data(
      List<EzBooking>.from(map['bookings']?.map((x) => EzBooking.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EzBookings.fromJson(String source) =>
      EzBookings.fromMap(json.decode(source));

  @override
  String toString() => 'EzBookings(bookings: $state)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EzBookings && listEquals(other.state, state);
  }

  @override
  int get hashCode => state.hashCode;

  EzBookings copyWith({
    List<EzBooking>? state,
  }) {
    return EzBookings.data(
      state ?? this.state,
    );
  }

  void addBooking(EzBooking booking) {
    state = [...state, booking];
    storage.write(key: 'bookings', value: toJson());
  }

  void removeBooking(EzBooking booking) {
    state = [
      for (final book in state)
        if (book != booking) book,
    ];
    storage.write(key: 'bookings', value: toJson());
  }
}

final ezBookingLoaderProvider = FutureProvider<EzBookings>((ref) async {
  final s = await storage.read(key: 'bookings');
  return EzBookings.fromJson(s ?? '{"bookings": []}');
});

final ezBookingProvider =
    StateNotifierProvider<EzBookings, List<EzBooking>>((ref) {
  return ref.watch(ezBookingLoaderProvider).when(
      data: (e) => e,
      error: (_, __) => EzBookings.error(),
      loading: () => EzBookings.load());
});

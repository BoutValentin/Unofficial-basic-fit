import 'package:basicfitsmartbooking/Models/ez_booking.dart';
import 'package:basicfitsmartbooking/Requests/log_request.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

final credentialsProvider = FutureProvider<Map<String, String>?>((ref) async {
  String? email = await storage.read(key: 'email');
  String? pwd = await storage.read(key: 'pwd');
  if (email is String && pwd is String) {
    Map<String, String> map = {};
    map['email'] = email;
    map['pwd'] = pwd;
    final user = await LogRequest().login(email, pwd, ref);
    if (user != null) {
      ref.read(userLogProvider.state).state = user;
      print("Log In.");
    } else {
      return null;
    }
    return map;
  }
  return null;
});

final routingProvider = StateProvider<String>((ref) {
  AsyncValue<Map<String, String>?> maps = ref.watch(credentialsProvider);
  return maps.when(
      data: (cong) => cong != null ? '/' : '/credentials',
      error: (_, __) => '/error',
      loading: () => '/load');
});

final ezBookingDetailsProvider = StateProvider<EzBooking?>((ref) {
  return null;
});

import 'package:basicfitsmartbooking/AppBar/appbarc.dart';
import 'package:basicfitsmartbooking/Navigation/simple_nav.dart';
import 'package:basicfitsmartbooking/Pages/add_page.dart';
import 'package:basicfitsmartbooking/Pages/booking_page.dart';
import 'package:basicfitsmartbooking/Pages/credentials_page.dart';
import 'package:basicfitsmartbooking/Pages/ez_booking_details_page.dart';
import 'package:basicfitsmartbooking/Pages/home_page.dart';
import 'package:basicfitsmartbooking/Pages/loading_page.dart';
import 'package:basicfitsmartbooking/Pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

Map<int, Color> color = {
  50: const Color.fromRGBO(254, 112, 0, .1),
  100: const Color.fromRGBO(254, 112, 0, .2),
  200: const Color.fromRGBO(254, 112, 0, .3),
  300: const Color.fromRGBO(254, 112, 0, .4),
  400: const Color.fromRGBO(254, 112, 0, .5),
  500: const Color.fromRGBO(254, 112, 0, .6),
  600: const Color.fromRGBO(254, 112, 0, .7),
  700: const Color.fromRGBO(254, 112, 0, .8),
  800: const Color.fromRGBO(254, 112, 0, .9),
  900: const Color.fromRGBO(254, 112, 0, 1),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Fit Ez Book',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: MaterialColor(0xFFfe7000, color),
      ),
      home: const Router(),
    );
  }
}

class Router extends ConsumerWidget {
  const Router({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rout = ref.watch(routingProvider);
    if (rout == '/') {
      return const HomePage();
    }
    if (rout == '/credentials') {
      return const CredentialsPage();
    }
    if (rout == '/load') {
      return const LoadingPage();
    }
    if (rout == '/add') {
      return const AddPage();
    }
    if (rout == '/curr') {
      return const BookingPage();
    }
    if (rout.startsWith('/settings')) {
      return const SettingsPage();
    }
    if (rout.startsWith('/ezbook')) {
      return const EzBookingDetailsPage();
    }
    return Scaffold(
      body: TextButton(
        child: Text("An error occur!"),
        onPressed: () {
          ref.read(routingProvider.state).state = '/credentials';
        },
      ),
    );
  }
}

import 'package:basicfitsmartbooking/AppBar/appbarc.dart';
import 'package:basicfitsmartbooking/AppBar/bottom_app_bar_c.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBarC().build(context, ref),
        bottomNavigationBar: const BottomAppBarC(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                    "Disclaimer: This app is not the official application of the Basic Fit. I'm not related to any content of basic fit. "),
                const Text(
                    "Your personals tokens are only saved on your local phone. I can't, wouldn't and will not use any possible way to retrieve that type of information."),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "If this app is useful to you, consider supporting me below ❤️",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.white),
                            elevation: MaterialStateProperty.resolveWith(
                                (states) => 2)),
                        onPressed: () async {
                          await launch(
                            Uri(
                              scheme: 'mailto',
                              path: 'contact@boutvalentin.com',
                            ).toString(),
                          );
                        },
                        icon: const Icon(Icons.mail),
                        label: const Text("Contact me")),
                    TextButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.white),
                            elevation: MaterialStateProperty.resolveWith(
                                (states) => 2)),
                        onPressed: () async {
                          await launch("https://paypal.me/boutvalentin");
                          //TODO: add website support
                          //await launch("https://supports.boutvalentin.com");
                        },
                        icon: const Icon(Icons.attach_money),
                        label: const Text("Supports me"))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

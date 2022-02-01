import 'package:basicfitsmartbooking/AppBar/appbarc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBarC(
          boolWithIcon: false,
        ).build(context, ref),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "If this app is usefull to you, consider supporting me in setttings ❤️",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: const [
                    Text(
                      "We try to connect you to basic fit... this can take up to 10 seconds...",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Tips: This app is not the official application of the Basic Fit. I'm not related to any content of basic fit. ",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Tips: Your personals tokens are only saved on your local phone. I can't, wouldn't and will not use any possible way to retrieve that type of information.",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

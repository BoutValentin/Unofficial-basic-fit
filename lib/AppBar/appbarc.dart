import 'dart:ffi';

import 'package:basicfitsmartbooking/Navigation/simple_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarC extends ConsumerWidget {
  bool boolWithIcon;
  AppBarC({Key? key, this.boolWithIcon = true}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: boolWithIcon
          ? GestureDetector(
              onTap: () {
                ref.read(routingProvider.state).state = '/settings';
              },
              child: const Icon(Icons.settings))
          : null,
      title: const Text("Unofficial Basic Fit 💪"),
      backgroundColor: Colors.white,
      shadowColor: Theme.of(context).primaryColor.withAlpha(50),
      elevation: 1,
      foregroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
    );
  }
}

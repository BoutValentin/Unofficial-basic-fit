import 'package:basicfitsmartbooking/Navigation/simple_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomAppBarC extends ConsumerWidget {
  const BottomAppBarC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routingProvider);
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                ref.read(routingProvider.state).state = '/';
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home,
                    color: route == '/'
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                    size: 30,
                  ),
                  Text(
                    "PRESETS",
                    style: TextStyle(
                        color: route == '/'
                            ? Theme.of(context).primaryColor
                            : Colors.black,
                        fontSize: 10),
                  )
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  ref.read(routingProvider.state).state = '/curr';
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/haltere.png',
                      color: route == '/curr'
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                      height: 30,
                    ),
                    Text(
                      "BOOKED",
                      style: TextStyle(
                          color: route == '/curr'
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                          fontSize: 10),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

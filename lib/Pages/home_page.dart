import 'package:basicfitsmartbooking/AppBar/appbarc.dart';
import 'package:basicfitsmartbooking/AppBar/bottom_app_bar_c.dart';
import 'package:basicfitsmartbooking/Models/ez_booking.dart';
import 'package:basicfitsmartbooking/Models/ez_bookings.dart';
import 'package:basicfitsmartbooking/Navigation/simple_nav.dart';
import 'package:basicfitsmartbooking/Requests/friends_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bookings = ref.watch(ezBookingProvider.notifier);
    final bookings_l = ref.watch(ezBookingProvider);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBarC().build(context, ref),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          ref.read(routingProvider.state).state = '/add';
        },
        tooltip: "Add a easy booking.",
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      bottomNavigationBar: const BottomAppBarC(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your presets",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (bookings.error) const Text("error when load"),
              if (bookings.load) const Text("loading"),
              if (bookings_l.isEmpty)
                const Text("You don't have any preset yet."),
              ...bookings_l
                  .asMap()
                  .map((i, book) {
                    return MapEntry(
                        i,
                        PresetCard(
                          book: book,
                          place: i,
                        ));
                  })
                  .values
                  .toList(),
              TextButton(
                  onPressed: () {
                    storage.delete(key: 'email');
                    storage.delete(key: 'pwd');
                    ref.refresh(credentialsProvider);
                  },
                  child: const Text("Change your authentification token"))
            ],
          ),
        ),
      ),
    );
  }
}

class PresetCard extends ConsumerWidget {
  final EzBooking book;
  final int place;
  const PresetCard({Key? key, required this.book, this.place = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: GestureDetector(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            constraints:
                const BoxConstraints(minWidth: double.infinity, minHeight: 150),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    book.assets,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                    child: Container(
                  color: const Color(0xAA000000),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      RoundedInfo(
                          icon: Icons.location_on_outlined,
                          text: book.club.name),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          RoundedInfo(
                            icon: Icons.access_time,
                            text: book.hour,
                            secondary: true,
                          ),
                          const SizedBox(width: 10),
                          RoundedInfo(
                            icon: Icons.timer,
                            text: "${book.duration} minutes",
                            secondary: true,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            ref.read(ezBookingDetailsProvider.state).state =
                                book;
                            ref.read(routingProvider.state).state =
                                '/ezbook/${book.id}';
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Book Me 🏋️",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool secondary;
  const RoundedInfo(
      {Key? key,
      required this.icon,
      required this.text,
      this.secondary = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:
              Theme.of(context).primaryColor.withAlpha(secondary ? 220 : 255),
          borderRadius: BorderRadius.circular(80)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 15,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

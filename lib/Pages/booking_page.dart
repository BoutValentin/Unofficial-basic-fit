import 'package:basicfitsmartbooking/AppBar/appbarc.dart';
import 'package:basicfitsmartbooking/AppBar/bottom_app_bar_c.dart';
import 'package:basicfitsmartbooking/Models/booking.dart';
import 'package:basicfitsmartbooking/Pages/home_page.dart';
import 'package:basicfitsmartbooking/Requests/book_training_request.dart';
import 'package:basicfitsmartbooking/Requests/current_booking_request.dart';
import 'package:basicfitsmartbooking/Requests/log_request.dart';
import 'package:basicfitsmartbooking/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingPage extends ConsumerWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarC().build(context, ref),
      bottomNavigationBar: const BottomAppBarC(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Booked Training",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ref.watch(currentBookingProvider).when(
                      data: (e) {
                        if (e.isEmpty) {
                          return Column(
                            children: [
                              const Text(
                                "You don't have any reservations yet. 😉",
                                textAlign: TextAlign.center,
                              ),
                              TextButton(
                                  onPressed: () {
                                    ref.refresh(currentBookingProvider);
                                  },
                                  child: const Text("Reload"))
                            ],
                          );
                        }
                        return Column(
                          children: [
                            ListViewBooking(
                              bookings: e,
                            ),
                            TextButton(
                                onPressed: () {
                                  ref.refresh(currentBookingProvider);
                                },
                                child: const Text("Reload"))
                          ],
                        );
                      },
                      error: (_, __) => Column(
                            children: [
                              Text("An error occur"),
                              TextButton(
                                  onPressed: () {
                                    ref.refresh(currentBookingProvider);
                                  },
                                  child: Text("Reload"))
                            ],
                          ),
                      loading: () => CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListViewBooking extends ConsumerWidget {
  final List<Booking> bookings;
  const ListViewBooking({Key? key, required this.bookings}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int i = 0;
    return Column(
      children: bookings.map<Widget>((e) {
        DateTime start = DateTime.parse(e.startDateTime);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
          child: Container(
            constraints: const BoxConstraints(minHeight: 100),
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                        Color(0xAA000000), BlendMode.darken),
                    image: AssetImage('assets/images/book-${i++}.jpg')),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      e.clubName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundedInfo(icon: Icons.access_time, text: formatDate(start)),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundedInfo(icon: Icons.timer, text: "${e.duration} minutes"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Friends:",
                    style: TextStyle(color: Colors.white),
                  ),
                  if (e.friends.isEmpty)
                    const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "You are an alone workout guy 💪",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        )),
                  const SizedBox(
                    height: 10,
                  ),
                  ...e.friends
                      .map<Widget>((e) => Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: RoundedInfo(
                                icon: Icons.emoji_emotions_outlined,
                                text: e.name_g),
                          ))
                      .toList(),
                  const SizedBox(
                    height: 24,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextButton.icon(
                          onPressed: () async {
                            final cookies = ref.read(cookieLogProvider);
                            final rep = await BookTrainingRequest()
                                .removeTraining(e.doorPolicyPeopleId,
                                    cookies.cookiesString());
                            print(rep);
                            ref.refresh(currentBookingProvider);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red.shade600,
                          ),
                          label: Text(
                            "Unbook",
                            style: TextStyle(color: Colors.red.shade600),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

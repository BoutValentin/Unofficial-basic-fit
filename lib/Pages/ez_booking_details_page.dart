import 'package:basicfitsmartbooking/AppBar/appbarc.dart';
import 'package:basicfitsmartbooking/AppBar/bottom_app_bar_c.dart';
import 'package:basicfitsmartbooking/Models/ez_booking.dart';
import 'package:basicfitsmartbooking/Models/ez_bookings.dart';
import 'package:basicfitsmartbooking/Models/friend.dart';
import 'package:basicfitsmartbooking/Navigation/simple_nav.dart';
import 'package:basicfitsmartbooking/Pages/add_page.dart';
import 'package:basicfitsmartbooking/Pages/booking_page.dart';
import 'package:basicfitsmartbooking/Pages/home_page.dart';
import 'package:basicfitsmartbooking/Requests/book_training_request.dart';
import 'package:basicfitsmartbooking/Requests/current_booking_request.dart';
import 'package:basicfitsmartbooking/Requests/friends_request.dart';
import 'package:basicfitsmartbooking/Requests/log_request.dart';
import 'package:basicfitsmartbooking/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EzBookingDetailsPage extends ConsumerStatefulWidget {
  const EzBookingDetailsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EzBookingDetailsPageState();
}

final nullFriends = Friend(
    email: "",
    name_g: "No Friend 😢",
    people_id_g: "",
    id_g: "",
    first_name_g: "",
    last_name_g: "");

class _EzBookingDetailsPageState extends ConsumerState<EzBookingDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? choose;
  Friend? friend;

  @override
  Widget build(BuildContext context) {
    final book = ref.watch(ezBookingDetailsProvider);
    precacheImage(AssetImage(book?.assets ?? ''), context);
    final friends_l = ref.watch(friendRequestProvider);
    return Scaffold(
        appBar: AppBarC().build(context, ref),
        bottomNavigationBar: BottomAppBarC(),
        body: book == null
            ? Text("You shoul selected a preset to see details")
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 10,
                            )
                          ]),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.elliptical(30, 20),
                              bottomRight: Radius.elliptical(30, 20),
                            ),
                            child: Container(
                              height: 230,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                      child: Image.asset(
                                    book.assets,
                                    fit: BoxFit.cover,
                                  )),
                                  Positioned.fill(
                                      child: Container(
                                    color: const Color(0xAA000000),
                                  )),
                                  Positioned(
                                      bottom: 20,
                                      right: 20,
                                      child: ClipOval(
                                        child: Material(
                                          elevation: 4,
                                          shadowColor: Theme.of(context)
                                              .primaryColor
                                              .withAlpha(255),
                                          color: Colors.white,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: GestureDetector(
                                              onTap: () {
                                                ref
                                                    .read(ezBookingProvider
                                                        .notifier)
                                                    .removeBooking(book);
                                                ref
                                                    .read(routingProvider.state)
                                                    .state = '/';
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Succefully Remove Training Preset 💪')),
                                                );
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red.shade700,
                                                size: 27,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          book.name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 23),
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
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Date: ${choose == null ? "Please select a date" : formatDateWithoutHour(choose!)}"),
                                ElevatedButton(
                                    onPressed: () async {
                                      final date = await showDatePicker(
                                          context: context,
                                          initialDate: choose ?? DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100));
                                      if (date != null && date != choose) {
                                        setState(() {
                                          choose = date;
                                        });
                                      }
                                    },
                                    child: const Text("Select a Date")),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: friends_l.when(
                              data: (e) {
                                if (!e.contains(nullFriends)) {
                                  e.insert(0, nullFriends);
                                }

                                return DropdownButtonFormField<Friend>(
                                    hint:
                                        const Text("Add a friend with you 🏋️"),
                                    value: friend,
                                    items: e.map<DropdownMenuItem<Friend>>(
                                        (Friend e) {
                                      return DropdownMenuItem<Friend>(
                                          value: e, child: Text(e.name_g));
                                    }).toList(),
                                    onChanged: (Friend? str) {
                                      if (str != null &&
                                          str.name_g != nullFriends.name_g) {
                                        setState(() {
                                          friend = str;
                                        });
                                      }
                                    });
                              },
                              error: (_, __) => const Text("An error occured"),
                              loading: () => const CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.resolveWith(
                                      (states) => 2),
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) =>
                                              Theme.of(context).primaryColor),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Colors.white)),
                              onPressed: () async {
                                if (choose == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Cannot proceed: You should select a date ⚠️')),
                                  );
                                  return;
                                }
                                final cookies = ref.read(cookieLogProvider);
                                final booktrreq = BookTrainingRequest();
                                final res = await booktrreq.getDisponibility(
                                    book.club.id,
                                    '${choose!.year}-${intToDoubleNum(choose!.month)}-${intToDoubleNum(choose!.day)}',
                                    cookies.cookiesString());
                                if (res is! List && res['error'] != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Error: It's appear you already have book 2 training and basic fit limit to 2.")),
                                  );
                                  return;
                                }
                                dynamic doorPolicy = null;
                                int i = 0;
                                DateTime d = DateTime(
                                    choose!.year,
                                    choose!.month,
                                    choose!.day,
                                    book.getHourOfHour(),
                                    book.getMinutesOfHour());
                                while (i < res.length && doorPolicy == null) {
                                  if (DateTime.parse(res[i]['startDateTime'])
                                      .isAtSameMomentAs(d)) {
                                    doorPolicy = res[i];
                                  }
                                  i++;
                                }
                                if (doorPolicy != null) {
                                  final rep = await booktrreq.bookTraining(
                                      doorPolicy: doorPolicy,
                                      duration: book.duration,
                                      club: book.club,
                                      friend:
                                          friend?.name_g != nullFriends.name_g
                                              ? friend
                                              : null,
                                      cookies: cookies.cookiesString());
                                  if (rep['message'] == 'Booked') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Booking Done 💪')),
                                    );
                                    ref.refresh(currentBookingProvider);
                                    ref.read(routingProvider.state).state =
                                        '/curr';
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Ouch ! We are sorry, an error occured when we try to book your training 😢')),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Your club seems to be full at this date or not open ⚠️')),
                                  );
                                }
                              },
                              child: Container(
                                width: 80,
                                height: 30,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/haltere.png',
                                      height: 30,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text("Book")
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }
}

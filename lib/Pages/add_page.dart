import 'dart:math';

import 'package:basicfitsmartbooking/AppBar/appbarc.dart';
import 'package:basicfitsmartbooking/AppBar/bottom_app_bar_c.dart';
import 'package:basicfitsmartbooking/Models/club.dart';
import 'package:basicfitsmartbooking/Models/clubs.dart';
import 'package:basicfitsmartbooking/Models/ez_booking.dart';
import 'package:basicfitsmartbooking/Models/ez_bookings.dart';
import 'package:basicfitsmartbooking/Navigation/simple_nav.dart';
import 'package:basicfitsmartbooking/Requests/club_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trainingDuration = [30, 60, 90];

//6h00 -> 21h15
//9h00 -> 17h45
List<String> createPossibleBooking({bool isWeekEnd = false}) {
  final minutes = ['00', '15', '30', '45'];
  final hourRange = isWeekEnd
      ? List<int>.generate(9, (index) => index + 9)
      : List<int>.generate(16, (index) => index + 6);
  List<String> lst = [];
  for (var hour in hourRange) {
    for (var minute in minutes) {
      if (hour == 21 && minute != '00' && minute != '15') continue;
      lst.add("${hour}h$minute");
    }
  }
  return lst;
}

bool isLessThanNine(String s) {
  if (s.isEmpty) return false;
  var t = s.split('h');
  print(s);
  int tt = int.parse(t[0]);
  return tt < 9;
}

class AddPage extends ConsumerStatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  String name = '';
  String? hour;
  String? duration;
  String? searchClub;
  bool isActive = false;
  List<Club>? clubSearch;
  Club? club;
  bool isWeekend = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final crp = ref.watch(clubRequestProvider);
    final ezbsL = ref.watch(ezBookingProvider).length;
    return Scaffold(
      bottomNavigationBar: const BottomAppBarC(),
      appBar: AppBarC().build(context, ref),
      body: crp.when(
          data: (Clubs clubs) {
            if (clubs.clubs.isEmpty) {
              return const Text("An error occur when fetching clubs");
            }
            if (searchClub == null || searchClub!.isEmpty) {
              setState(() {
                clubSearch = clubs.clubs;
              });
            }
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        constraints: BoxConstraints(
                            minHeight: 200,
                            maxHeight: 200,
                            maxWidth: MediaQuery.of(context).size.width),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                  'assets/images/training-${(ezbsL + 1) % 7}.jpg',
                                  fit: BoxFit.cover),
                            ),
                            Positioned.fill(
                                child: Container(
                              color: const Color(0xAA000000),
                            )),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Add A Preset",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    color: Colors.white),
                              ),
                            ),
                            Positioned(
                              top: 50,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: const [
                                      Flexible(
                                        child: Text(
                                          "Do you always go to the gym at the same time? Create a preset to save you time.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            autofocus: false,
                            initialValue: name,
                            onChanged: (str) {
                              setState(() {
                                name = str;
                              });
                            },
                            validator: (str) {
                              if (str == null || str.isEmpty) {
                                return "Name cannot be blank";
                              }
                            },
                            decoration: const InputDecoration(
                                label: Text("Name of your preset*")),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Checkbox(
                                    value: isWeekend,
                                    onChanged: (b) {
                                      if (b != null &&
                                          b &&
                                          isLessThanNine(hour ?? '')) {
                                        setState(() {
                                          hour = "9h00";
                                        });
                                        print("changed $hour");
                                      }

                                      setState(() {
                                        isWeekend = b ?? false;
                                      });
                                    }),
                                const Text("Is a weekend preset ?")
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          DropdownButtonFormField<String>(
                              hint: const Text("Training hour"),
                              validator: (String? s) {
                                if (s == null || s.isEmpty) {
                                  return "Training hour cannot be blank";
                                }
                              },
                              value: hour,
                              items: createPossibleBooking(isWeekEnd: isWeekend)
                                  .map<DropdownMenuItem<String>>((String e) {
                                return DropdownMenuItem<String>(
                                    value: e, child: Text(e));
                              }).toList(),
                              onChanged: (String? str) {
                                if (str != null) {
                                  setState(() {
                                    hour = str;
                                  });
                                }
                              }),
                          const SizedBox(
                            height: 13,
                          ),
                          DropdownButtonFormField<String>(
                              hint: const Text("Training duration"),
                              validator: (String? s) {
                                if (s == null || s.isEmpty) {
                                  return "Training duration cannot be blank";
                                }
                              },
                              value: duration,
                              items: trainingDuration
                                  .map<DropdownMenuItem<String>>((int e) {
                                return DropdownMenuItem<String>(
                                    value: "$e", child: Text("$e minutes"));
                              }).toList(),
                              onChanged: (String? str) {
                                if (str != null) {
                                  setState(() {
                                    duration = str;
                                  });
                                }
                              }),
                          const SizedBox(
                            height: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(club == null
                                  ? "No club selected... Search your club ->"
                                  : club!.name),
                              Container(
                                width: 50,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isActive = true;
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.white),
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) => 1),
                                  ),
                                  child: const Icon(Icons.search),
                                ),
                              )
                            ],
                          ),
                          if (isActive)
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text("Search Your Club")),
                              onChanged: (s) {
                                setState(() {
                                  searchClub = s;
                                  clubSearch = clubs.search(s);
                                });
                              },
                            ),
                          if (isActive)
                            Container(
                              height: 200,
                              child: Scrollbar(
                                  child: Container(
                                padding: EdgeInsets.all(8),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: clubSearch
                                          ?.map((e) => Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: GestureDetector(
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFFeeeeee),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: Text(e.name)),
                                                  onTap: () {
                                                    setState(() {
                                                      club = e;
                                                      isActive = false;
                                                      searchClub = '';
                                                    });
                                                  },
                                                ),
                                              ))
                                          .toList() ??
                                      [Text("Aucun club trouver")],
                                ),
                              )),
                            ),
                          ElevatedButton(
                              onPressed: () async {
                                if (club == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'You should selected a Club ⚠️')),
                                  );
                                  return;
                                }
                                if (_formKey.currentState!.validate() &&
                                    club != null) {
                                  setState(() => isLoading = true);
                                  ref
                                      .read(ezBookingProvider.notifier)
                                      .addBooking(EzBooking(
                                          id: ezbsL + 1,
                                          name: name,
                                          hour: hour!,
                                          assets:
                                              "assets/images/training-${(ezbsL + 1) % 7}.jpg",
                                          duration: duration!,
                                          club: club!));
                                  ref.read(routingProvider.state).state = '/';
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Succefully Add Training Preset 💪')),
                                  );
                                  setState(() => isLoading = false);
                                }
                              },
                              child: Text("Create Preset 💪"))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (_, __) => Text("An error occur"),
          loading: () => const CircularProgressIndicator()),
    );
  }
}

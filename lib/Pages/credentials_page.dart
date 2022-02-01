import 'package:basicfitsmartbooking/AppBar/appbarc.dart';
import 'package:basicfitsmartbooking/Navigation/simple_nav.dart';
import 'package:basicfitsmartbooking/Requests/log_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CredentialsPage extends ConsumerStatefulWidget {
  const CredentialsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CredentialsPageState();
}

class _CredentialsPageState extends ConsumerState<CredentialsPage> {
  String? email = '';
  String? pwd = '';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarC(
        boolWithIcon: false,
      ).build(context, ref),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Stack(
                  children: [
                    if (isLoading)
                      Positioned.fill(
                        child: Container(
                          color: const Color(0xAA000000),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    Column(
                      children: [
                        const Text(
                          "Provide your my.basic-fit.com credentials ⬇",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        TextFormField(
                          autocorrect: false,
                          decoration:
                              const InputDecoration(labelText: 'Email *'),
                          initialValue: '',
                          onChanged: (String? str) {
                            setState(() {
                              email = str;
                            });
                          },
                          validator: (String? str) {
                            if (str == null) {
                              return "Email cannot be null";
                            }
                            if (str.isEmpty) return "Email cannot be empty";

                            if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(str)) {
                              return "Invalid email format";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          autocorrect: false,
                          decoration:
                              const InputDecoration(labelText: 'Password *'),
                          initialValue: '',
                          onChanged: (String? str) {
                            setState(() {
                              pwd = str;
                            });
                          },
                          validator: (String? str) {
                            if (str == null) {
                              return "Password cannot be null";
                            }
                            if (str.isEmpty) return "Password cannot be empty";
                          },
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                setState(() => isLoading = true);
                                storage.write(key: 'email', value: email);
                                storage.write(key: 'pwd', value: pwd);
                                ref.refresh(credentialsProvider).when(
                                    data: (_) {
                                      final user = ref.read(userLogProvider);
                                      print(user);
                                      setState(() => isLoading = false);
                                      if (user != null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Credentials Save and log succedd')),
                                        );
                                      } else {
                                        setState(() => isLoading = false);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('Log in Error')),
                                        );
                                      }
                                    },
                                    error: (_, __) {
                                      setState(() => isLoading = false);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Log in Error')),
                                      );
                                    },
                                    loading: () {});
                              }
                            },
                            child: Text("Log in")),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Tips: This app is not the official application of the Basic Fit. I'm not related to any content of basic fit. ",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Tips: Your personals tokens are only saved on your local phone. I can't, wouldn't and will not use any possible way to retrieve that type of information.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "If this app is usefull to you, consider supporting me in setttings ❤️",
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

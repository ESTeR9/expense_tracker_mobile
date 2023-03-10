import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/login_bloc.dart';
import 'package:expense_tracker/core/login_states.dart';

import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  LoginBloc _loginbloc = LoginBloc();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, IconData>> data = [];
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  void validateInputs(String email, String password) {
    widget._loginbloc.validateInputs(email, password);
  }

  void fieldChanged(String text) {
    widget._loginbloc.fieldChanged(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LogInState>(
        bloc: widget._loginbloc,
        listenWhen: (oldState, newState) {
          return newState is LoggedInSuccessfully;
        },
        listener: (context, state) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewPage()));
        },
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Flexible(
                  flex: 4,
                  child: Image(
                      image: AssetImage('resources/images/flutter_logo.png')),
                ),
                Flexible(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                          child: BlocBuilder<LoginBloc, LogInState>(
                        bloc: widget._loginbloc,
                        buildWhen: (oldState, newState) {
                          return (newState is InvalidEmail) ||
                              ((newState is FieldChange) &&
                                  ((oldState is InvalidEmail) ||
                                      (oldState is InvalidPassword) ||
                                      (oldState is IncorrectCredentials)));
                        },
                        builder: (context, state) {
                          bool invalidEmail;
                          if (state is FieldChange) {
                            invalidEmail = false;
                          } else {
                            invalidEmail =
                                (state is InvalidEmail) ? true : false;
                          }
                          return TextField(
                            controller: emailFieldController,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              //TODO tackle with overflows and use labelText
                              hintText: "email",
                              errorText: invalidEmail ? "Invalid Email" : null,
                            ),
                            onChanged: (text) => {
                              fieldChanged(text),
                            },
                          );
                        },
                      )),
                      Flexible(
                          // padding: const EdgeInsets.all(20),
                          child: BlocBuilder<LoginBloc, LogInState>(
                        bloc: widget._loginbloc,
                        buildWhen: (oldState, newState) {
                          return (newState is InvalidPassword) ||
                              ((newState is FieldChange) &&
                                  ((oldState is InvalidEmail) ||
                                      (oldState is InvalidPassword) ||
                                      (oldState is IncorrectCredentials)));
                        },
                        builder: (context, state) {
                          bool invalidPassword;
                          if (state is FieldChange) {
                            invalidPassword = false;
                          } else {
                            invalidPassword =
                                (state is InvalidPassword) ? true : false;
                          }
                          return TextField(
                            obscureText: true,
                            controller: passwordFieldController,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              hintText: "password",
                              errorText:
                                  invalidPassword ? "Invalid Password" : null,
                            ),
                            onChanged: (text) => {
                              fieldChanged(text),
                            },
                          );
                        },
                      )),
                      Flexible(
                        child: BlocBuilder<LoginBloc, LogInState>(
                          bloc: widget._loginbloc,
                          buildWhen: (oldState, newState) {
                            return (newState is IncorrectCredentials) ||
                                (newState is FieldChange);
                          },
                          builder: (context, state) {
                            if (state is IncorrectCredentials) {
                              return const Text("Incorrect Credentials",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ));
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: 140,
                          height: 55,
                          padding: const EdgeInsets.only(top: 10),
                          child: BlocBuilder<LoginBloc, LogInState>(
                            bloc: widget._loginbloc,
                            buildWhen: (oldState, newState) {
                              return (newState is InvalidEmail) ||
                                  (newState is InvalidPassword) ||
                                  (newState is FieldChange) ||
                                  (newState is IncorrectCredentials);
                            },
                            builder: (context, state) {
                              bool areFieldsNotEmpty =
                                  emailFieldController.text.isNotEmpty &&
                                      passwordFieldController.text.isNotEmpty;
                              bool areFieldsValid = !((state is InvalidEmail) ||
                                  (state is InvalidPassword));
                              bool buttonEnable;
                              if (state is FieldChange) {
                                buttonEnable = areFieldsNotEmpty;
                              } else if (state is IncorrectCredentials) {
                                buttonEnable = false;
                              } else {
                                buttonEnable =
                                    areFieldsNotEmpty && areFieldsValid;
                              }
                              return ElevatedButton(
                                  onPressed: !buttonEnable
                                      ? null
                                      : () => {
                                            validateInputs(
                                                emailFieldController.text,
                                                passwordFieldController.text)
                                          },
                                  child: const Text("Sign in",
                                      style: TextStyle(
                                        fontSize: 22,
                                      )));
                            },
                          ),
                        ),
                      ),
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

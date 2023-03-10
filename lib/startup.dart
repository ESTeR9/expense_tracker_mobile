import "package:config/config.dart";
import "package:flutter/material.dart";
import "pages/login_page.dart";

void startup() async {
  String env = const String.fromEnvironment("ENV", defaultValue: "local");
  await initConfig(env);

  runApp(const LoginPage());
}

import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            child: const Text("Logout"),
            onTap: () => {
                  Navigator.pop(context),
                }),
      ),
    );
  }
}

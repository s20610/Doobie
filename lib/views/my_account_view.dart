import 'package:flutter/material.dart';

class MyAccountview extends StatefulWidget {
  const MyAccountview({Key? key}) : super(key: key);

  @override
  State<MyAccountview> createState() => _MyAccountviewState();
}

class _MyAccountviewState extends State<MyAccountview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: const Center(
        child: Text('My Profile'),
      ),
    );
  }
}

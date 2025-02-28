import 'package:flutter/material.dart';

class PerpetualScreen extends StatefulWidget {
  const PerpetualScreen({super.key});

  @override
  State<PerpetualScreen> createState() => _PerpetualScreenState();
}

class _PerpetualScreenState extends State<PerpetualScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Perpetual Trading",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text(
          "Perpetual Trading Coming Soon...",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}

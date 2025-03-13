import 'package:flutter/material.dart';
import 'package:signalwavex/settings/language.dart';
import 'package:signalwavex/settings/password.dart';
import 'package:signalwavex/settings/profile.dart';
import 'package:signalwavex/settings/verification.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabBar(
            unselectedLabelStyle: const TextStyle(fontSize: 10),
            controller: _tabController,
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.yellow,
            tabs: const [
              Tab(text: "Profile"),
              Tab(text: "Transaction History"),
              Tab(text: "Password"),
              Tab(text: "Verification"),
              Tab(text: "Language"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ProfileSection(),
                TransactionHistorySection(),
                PasswordSection(),
                VerificationSection(),
                LanguageSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionHistorySection extends StatelessWidget {
  const TransactionHistorySection({super.key});
  @override
  Widget build(BuildContext context) {
    return const Text("Transaction History",
        style: TextStyle(color: Colors.white));
  }
}

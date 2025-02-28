import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "General",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.white),
              title: const Text("Enable Notifications",
                  style: TextStyle(color: Colors.white)),
              trailing: Switch(
                value: notificationsEnabled,
                activeColor: Colors.yellow,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.white),
              title: const Text("Privacy Settings",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to Privacy Settings (Implement Later)
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text("About", style: TextStyle(color: Colors.white)),
              onTap: () {
                // Show About Dialog or Navigate to About Page
              },
            ),
          ],
        ),
      ),
    );
  }
}

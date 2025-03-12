import 'package:flutter/material.dart';
import 'package:signalwavex/component/textform_filled.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Language",
            style: TextStyle(
              fontFamily: 'inter',
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "choose your language",
            style: TextStyle(
              fontFamily: 'inter',
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          TextFormFieldWithCustomStyles(
            height: 34,
            width: 386,
            fillColor: Colors.black,
            controller: newPasswordController,
            label: "English",
            hintText: "Enter new password",
            obscureText: true,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Handle save action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Save Changes",
                style: TextStyle(
                  fontFamily: 'inter',
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

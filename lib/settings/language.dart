import 'package:flutter/material.dart';
import 'package:signalwavex/languages.dart';

class LanguageSection extends StatefulWidget {
  const LanguageSection({super.key});

  @override
  State<LanguageSection> createState() => _LanguageSectionState();
}

class _LanguageSectionState extends State<LanguageSection> {
  // String? selectedLanguageCode;
  final Map<String, String> languages = {
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'ja': 'Japanese',
    'ru': 'Russian',
    'ar': 'Arabic',
    'pt': 'Portuguese',
    'hi': 'Hindi',
    'yo': 'Yoruba',
    'ig': 'Igbo',
  };

  @override
  void initState() {
    super.initState();
    // Set default language (optional)
    // selectedLanguageCode = 'en';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            toCurrentLanguageFunction("Language"),
            style: TextStyle(
              fontFamily: 'inter',
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            toCurrentLanguageFunction("Choose your language"),
            style: TextStyle(
              fontFamily: 'inter',
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField<String>(
              value: currentLanguage,
              dropdownColor: Colors.black,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'inter',
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              hint: Text(
                toCurrentLanguageFunction("Select language"),
                style: TextStyle(color: Colors.white70),
              ),
              items: languages.entries.map((entry) {
                return DropdownMenuItem<String>(
                  value: entry.value,
                  child: Text(entry.value),
                );
              }).toList(),
              onChanged: (value) {
                currentLanguage = value ?? currentLanguage;
                setState(() {
                  // selectedLanguageCode = value;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                if (currentLanguage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${toCurrentLanguageFunction("Selected language")}: ${currentLanguage!}",
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(toCurrentLanguageFunction(
                            "Please select a language"))),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                toCurrentLanguageFunction("Save Changes"),
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

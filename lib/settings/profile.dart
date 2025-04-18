import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signalwavex/component/textform_filled.dart';
import 'package:signalwavex/languages.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _onSave() {
    if (_fullName.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    // You can print or directly use these values for an API call
    print("Full Name: ${_fullName.text}");
    print("Phone: ${_phoneController.text}");
    print("Image path: ${_selectedImage?.path ?? "No image selected"}");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Changes saved successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("My Profile".toCurrentLanguage(),
              style: const TextStyle(
                fontFamily: 'inter',
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 20),

          // Avatar
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: _selectedImage != null
                    ? FileImage(_selectedImage!)
                    : const AssetImage('assets/images/profile.png')
                        as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.camera_alt, color: Colors.white70),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Full Name
          Text("Full Name".toCurrentLanguage(),
              style: const TextStyle(color: Colors.white, fontSize: 10)),
          const SizedBox(height: 8),
          TextFormFieldWithCustomStyles(
            controller: _fullName,
            hintStyle: const TextStyle(fontSize: 10),
            height: 34,
            width: 400,
            label: 'Full name'.toCurrentLanguage(),
            hintText: 'Enter your full name'.toCurrentLanguage(),
            fillColor: Colors.black,
            labelColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.6),
            textColor: Colors.white,
            prefixImagePath: 'assets/icons/cu.png',
          ),

          const SizedBox(height: 20),

          // Phone Number
          Text("Phone Number".toCurrentLanguage(),
              style: const TextStyle(color: Colors.white, fontSize: 10)),
          const SizedBox(height: 8),
          TextFormFieldWithCustomStyles(
            controller: _phoneController,
            hintStyle: const TextStyle(fontSize: 10),
            height: 34,
            width: 400,
            label: 'Phone Number'.toCurrentLanguage(),
            hintText: 'Enter your phone number'.toCurrentLanguage(),
            fillColor: Colors.black,
            labelColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.6),
            textColor: Colors.white,
            prefixImagePath: 'assets/icons/bitcoin.png',
          ),

          const SizedBox(height: 30),

          // Save Button
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: _onSave,
              child: Container(
                height: 40,
                width: 123,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Save Changes".toCurrentLanguage(),
                    style: const TextStyle(
                      fontFamily: 'inter',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

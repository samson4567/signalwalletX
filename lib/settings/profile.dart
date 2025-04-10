import 'package:flutter/material.dart';
import 'package:signalwavex/component/textform_filled.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController =
      TextEditingController(); // Added phone controller
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My Profile",
            style: TextStyle(
              fontFamily: 'inter',
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Column(
            children: [
              Text(
                "Avatar",
                style: TextStyle(
                  fontFamily: 'inter',
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Full Name",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          const SizedBox(height: 8),
          TextFormFieldWithCustomStyles(
            hintStyle: const TextStyle(fontSize: 10),
            height: 34,
            width: 400,
            controller: _fullName,
            label: 'Full name',
            hintText: 'Enter your full name',
            fillColor: Colors.black,
            labelColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.6),
            textColor: Colors.white,
            prefixImagePath: 'assets/icons/cu.png',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your fullName';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Text(
            "Email",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          const SizedBox(height: 8),
          TextFormFieldWithCustomStyles(
            hintStyle: const TextStyle(fontSize: 10),
            height: 34,
            width: 400,
            controller: _emailController,
            label: 'Email',
            hintText: 'Enter your email',
            fillColor: Colors.black,
            labelColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.6),
            textColor: Colors.white,
            prefixImagePath: 'assets/icons/mail.png',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Text(
            "Phone Number",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          const SizedBox(height: 8),
          TextFormFieldWithCustomStyles(
            hintStyle: const TextStyle(fontSize: 10),
            height: 34,
            width: 400,
            controller: _phoneController,
            label: 'Phone Number',
            hintText: 'Enter your phone number',
            fillColor: Colors.black,
            labelColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.6),
            textColor: Colors.white,
            prefixImagePath:
                'assets/icons/bitcoin.png', // You can replace with the phone icon
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              // Optionally, add phone number validation
              return null;
            },
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 40,
              width: 123,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                    fontFamily: 'inter',
                    color: Colors.black,
                    fontSize: 16,
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

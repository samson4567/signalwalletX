import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signalwavex/component/textform_filled.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_state.dart';
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
    if (_fullName.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill all fields and select an image")),
      );
      return;
    }

    context.read<AuthBloc>().add(ProfileUpdateEvent(
          name: _fullName.text,
          phoneNumber: _phoneController.text,
          profilePicture: _selectedImage!.path,
          imageFile: _selectedImage!,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccessState) {
          if (mounted) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Success"),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          }
        } else if (state is ProfileUpdateErrorState) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state is ProfileUpdateLoadingState;

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
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : const AssetImage('assets/images/profile.png')
                            as ImageProvider,
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.camera_alt, color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: isLoading ? null : _onSave,
                    child: Container(
                      height: 40,
                      width: 123,
                      decoration: BoxDecoration(
                        color: isLoading ? Colors.grey : Colors.yellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.black,
                                ),
                              )
                            : Text(
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
        },
      ),
    );
  }
}

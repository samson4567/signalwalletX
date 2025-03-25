import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/component/textform_filled.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_state.dart';

class PasswordSection extends StatefulWidget {
  const PasswordSection({super.key});

  @override
  State<PasswordSection> createState() => _PasswordSectionState();
}

class _PasswordSectionState extends State<PasswordSection> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Password",
            style: TextStyle(
              fontFamily: 'inter',
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildLabel("Current Password"),
          const SizedBox(height: 10),
          TextFormFieldWithCustomStyles(
            height: 34,
            width: 386,
            fillColor: Colors.black,
            controller: currentPasswordController,
            label: "Current Password",
            hintText: "Enter current password",
            obscureText: true,
          ),
          const SizedBox(height: 20),
          _buildLabel("New Password"),
          const SizedBox(height: 10),
          TextFormFieldWithCustomStyles(
            height: 34,
            width: 386,
            fillColor: Colors.black,
            controller: newPasswordController,
            label: "New Password",
            hintText: "Enter new password",
            obscureText: true,
          ),
          const SizedBox(height: 20),
          _buildLabel("Confirm Password"),
          const SizedBox(height: 10),
          TextFormFieldWithCustomStyles(
            fillColor: Colors.black,
            height: 34,
            width: 386,
            controller: confirmPasswordController,
            label: "Confirm Password",
            hintText: "Re-enter new password",
            obscureText: true,
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (BuildContext context, AuthState state) {
                if (state is UpdatePasswordSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("password updated successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is UpdatePasswordErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text("password update Failed ${state.errorMessage}"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    final currentPassword =
                        currentPasswordController.text.trim();
                    final newPassword = newPasswordController.text.trim();
                    final confirmPassword =
                        confirmPasswordController.text.trim();

                    if (newPassword == confirmPassword &&
                        newPassword.isNotEmpty) {
                      context.read<AuthBloc>().add(
                            UpdatePasswordEvent(
                              currentPassword: currentPassword,
                              newPassword: newPassword,
                              newPasswordConfirmation: confirmPassword,
                            ),
                          );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Passwords do not match"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: (state is UpdatePasswordLoadingState)
                      ? const SizedBox(
                          height: 40,
                          width: 150,
                          child: Center(
                            child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.black),
                          ),
                        )
                      : const Text(
                          "Save Changes",
                          style: TextStyle(
                            fontFamily: 'inter',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'inter',
        color: Colors.white,
        fontSize: 15,
      ),
    );
  }
}

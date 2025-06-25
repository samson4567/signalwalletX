import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/component/textform_filled.dart';
import 'package:signalwavex/features/user/domain/entities/kyc_request_entity.dart';
import 'package:signalwavex/features/user/presentation/blocs/auth_bloc/user_bloc.dart';
import 'package:signalwavex/features/user/presentation/blocs/auth_bloc/user_event.dart';
import 'package:signalwavex/languages.dart';

class VerificationSection extends StatelessWidget {
  const VerificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController idNumberController = TextEditingController();
    final TextEditingController countryController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "KYC".toCurrentLanguage(),
            style: const TextStyle(
              fontFamily: 'inter',
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildInput(
            label: "First Name",
            hint: "Enter first name",
            textEditingController: firstNameController,
          ),
          const SizedBox(height: 16),
          _buildInput(
            label: "Last Name",
            hint: "Enter last name",
            textEditingController: lastNameController,
          ),
          const SizedBox(height: 16),
          _buildInput(
            label: "Country",
            hint: "Enter country",
            textEditingController: countryController,
          ),
          const SizedBox(height: 16),
          _buildInput(
            label: "id",
            hint: "Enter id",
            textEditingController: idNumberController,
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                final kycRequestEntity = KycRequestEntity(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  idType: "nin",
                  country: countryController.text,
                  idNumber: idNumberController.text,
                );

                context
                    .read<UserBloc>()
                    .add(KycVerificationEvent(kycRequestEntity));
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
                "Send KYC Details".toCurrentLanguage(),
                style: const TextStyle(
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

  Column _buildInput({
    required TextEditingController textEditingController,
    required String label,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toCurrentLanguage(),
          style: const TextStyle(
            fontFamily: 'inter',
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        TextFormFieldWithCustomStyles(
          fillColor: Colors.black,
          height: 34,
          width: double.infinity,
          controller: textEditingController,
          label: label,
          hintText: hint.toCurrentLanguage(),
          obscureText: false, // changed to false unless this is password-like
        ),
      ],
    );
  }
}

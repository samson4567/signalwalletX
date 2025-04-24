import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/component/textform_filled.dart';
import 'package:signalwavex/features/user/domain/entities/kyc_request_entity.dart';
import 'package:signalwavex/features/user/presentation/blocs/auth_bloc/user_bloc.dart';
import 'package:signalwavex/features/user/presentation/blocs/auth_bloc/user_event.dart';
import 'package:signalwavex/feed/Features-UI/current_order_page.dart';
import 'package:signalwavex/languages.dart';
import 'package:signalwavex/settings/profile.dart';

class VerificationSection extends StatelessWidget {
  const VerificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController idNumberController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    // final TextEditingController firstNameController = TextEditingController();

    final TextEditingController lastNameController = TextEditingController();

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
          const SizedBox(height: 20),
          // Text(
          //   "First Name".toCurrentLanguage(),
          //   style: const TextStyle(
          //     fontFamily: 'inter',
          //     color: Colors.white,
          //     fontSize: 15,
          //   ),
          // ),
          // const SizedBox(height: 10),
          // TextFormFieldWithCustomStyles(
          //   height: 34,
          //   width: 386,
          //   fillColor: Colors.black,
          //   controller: newPasswordController,
          //   label: "First Name".toCurrentLanguage(),
          //   hintText: "Enter first name".toCurrentLanguage(),
          //   obscureText: true,
          // ),

          _buildInput(
            hint: "enter first Name",
            label: "first Name",
            textEditingController: firstNameController,
          ),
          const SizedBox(height: 20),
          _buildInput(
            hint: "enter last Name",
            label: "last Name",
            textEditingController: lastNameController,
          ),
          _buildInput(
            hint: "enter country",
            label: "country",
            textEditingController: countryController,
          ),
          _buildInput(
            hint: "enter nin",
            label: "nin",
            textEditingController: idNumberController,
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Handle save action
                KycRequestEntity kycRequestEntity = KycRequestEntity(
                  lastName: lastNameController.text,
                  firstName: firstNameController.text,
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
                "Send kyc Details".toCurrentLanguage(),
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
      children: [
        Text(
          "Last Name".toCurrentLanguage(),
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
          width: 386,
          controller: textEditingController,
          label: "Last Name",
          hintText: "Enter last name".toCurrentLanguage(),
          obscureText: true,
        ),
      ],
    );
  }
}

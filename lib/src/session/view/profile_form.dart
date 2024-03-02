import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synrg/synrg.dart';

///
class SynrgProfileForm extends StatelessWidget {
  ///
  SynrgProfileForm({super.key});

  ///

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _firstNameController,
          validator: validateFirstName,
          decoration: const InputDecoration(
            labelText: 'First Name',
          ),
        ),
        TextFormField(
          controller: _lastNameController,
          validator: validateLastName,
          decoration: const InputDecoration(
            labelText: 'Last Name',
          ),
        ),
        TextFormField(
          controller: _emailController,
          validator: validateEmailAddress,
          decoration: const InputDecoration(
            labelText: 'Email Address',
          ),
        ),
        TextFormField(
          controller: _phoneController,
          validator: validatePhoneNumber,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     if (_formKey.currentState!.validate()) {
        //       if (profile != null) {
        //         context.read<SynrSessionBloc>().add(
        //               SynrUpdateProfile(
        //                 profile: SynrgMinProfile(),
        //               ),
        //             );
        //       } else {
        //         context.read<SynrSessionBloc>().add(
        //               SynrUpdateProfile(
        //                 profile: profile.copyWith(),
        //               ),
        //             );
        //       }
        //     }
        //   },
        //   child: Text(
        //     'Update Profile',
        //     style: Theme.of(context).textTheme.bodyLarge,
        //   ),
        // ),
      ],
    );
  }
}

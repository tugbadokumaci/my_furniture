import 'package:flutter/material.dart';

class UserNameInputField extends StatelessWidget {
  final TextEditingController userNameController;
  final ValueChanged<String> onChanged;
  const UserNameInputField({super.key, required this.userNameController, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: userNameController,
      onChanged: onChanged,
      decoration: InputDecoration(hintText: 'Enter your username'),
    );
  }
}

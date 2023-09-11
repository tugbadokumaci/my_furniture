import 'package:flutter/material.dart';
import 'package:my_furniture/core/components/username_text_field.dart';
import 'package:my_furniture/core/init/cache/cache.dart';
import 'package:my_furniture/view/login/login_view_mixin.dart';
import 'package:my_furniture/view/login/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginViewMixin {
  final LoginViewModel _viewModel = LoginViewModel(Cache());

  final TextEditingController userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Column(
        children: [
          UserNameInputField(userNameController: userNameController, onChanged: onControllerChange),
          _SaveButton(
            isValidForTextController: isValidForTextController,
            onPressed: () async {
              final response = await _viewModel.controlToUserName(basicModel);
              await controlToResult(result: response);
            },
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.onPressed,
    required this.isValidForTextController,
  });

  final ValueNotifier<bool> isValidForTextController;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isValidForTextController,
        builder: (context, value, child) {
          return ElevatedButton(
            onPressed: value == false ? null : onPressed,
            child: const Text('Save'),
          );
        });
  }
}


// iş planım
// Validasyon yapılacak (username uzunlupu 3 ten buyuk olmalıdır)
// validasyon basarılı ise buton akrif olacak
// butona basıldıgında textcontroller degeri alıp servise yollasın
// servis cevabı alıp ekrana yazdırsın

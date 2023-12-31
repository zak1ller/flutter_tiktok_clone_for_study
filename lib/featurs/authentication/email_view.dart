import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/featurs/authentication/password_view.dart';
import 'package:tiktok_clone/featurs/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/featurs/authentication/widgets/form_button.dart';

class EmailViewArgs {
  final String username;
  EmailViewArgs({required this.username});
}

class EmailView extends ConsumerStatefulWidget {
  const EmailView({
    super.key,
    required this.username,
  });

  final String username;

  @override
  EmailViewState createState() => EmailViewState();
}

class EmailViewState extends ConsumerState<EmailView> {
  final TextEditingController _emailController = TextEditingController();

  String _email = "";

  @override
  void initState() {
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onScaffholdTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;

    ref.read(signUpForm.notifier).state = {"email": _email};

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PasswordView(),
      ),
    );
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) return "Email not valid";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffholdTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              Text(
                "What is your email, ${widget.username}",
                style: const TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                cursorColor: Theme.of(context).primaryColor,
                onEditingComplete: _onSubmit,
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: _isEmailValid(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              Gaps.v16,
              FormButton(
                onTap: _onSubmit,
                disabled: _email.isEmpty || _isEmailValid() != null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

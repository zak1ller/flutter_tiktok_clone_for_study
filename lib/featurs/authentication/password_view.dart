import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/featurs/authentication/birthday_view.dart';
import 'package:tiktok_clone/featurs/authentication/widgets/form_button.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _EmailViewState();
}

class _EmailViewState extends State<PasswordView> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";
  bool _obscureText = true;

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onScaffholdTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BirthdayView(),
      ),
    );
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _onObscureTap() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _isPasswordValid() {
    return _password.length >= 8;
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
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _passwordController,
                cursorColor: Theme.of(context).primaryColor,
                onEditingComplete: _onSubmit,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: "Make it strong.",
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
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _onObscureTap,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gaps.v16,
              const Text(
                "Your password must have:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v16,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h8,
                  const Text("8 to 20 characters"),
                ],
              ),
              Gaps.v16,
              FormButton(
                onTap: _onSubmit,
                disabled: !_isPasswordValid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

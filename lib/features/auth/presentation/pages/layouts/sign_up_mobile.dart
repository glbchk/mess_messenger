import 'package:flutter/material.dart';

class SignUpMobile extends StatelessWidget {
  final Widget formContent;
  const SignUpMobile({super.key, required this.formContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: formContent,
        ),
      ),
    );
  }
}

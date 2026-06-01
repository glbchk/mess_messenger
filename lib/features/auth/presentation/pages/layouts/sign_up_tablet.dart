import 'package:flutter/material.dart';

class SignUpTablet extends StatelessWidget {
  final Widget formContent;
  const SignUpTablet({super.key, required this.formContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: formContent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

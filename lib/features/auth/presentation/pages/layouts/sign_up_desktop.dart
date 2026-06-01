import 'package:flutter/material.dart';

class SignUpDesktop extends StatelessWidget {
  final Widget formContent;
  const SignUpDesktop({super.key, required this.formContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: const Center(
                child: Text(
                  'Your Cool App Logo',
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: formContent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

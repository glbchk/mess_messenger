import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class AuthMobileLayout extends StatelessWidget {
  final Widget formContent;
  final PreferredSizeWidget? appBar;

  const AuthMobileLayout({super.key, required this.formContent, this.appBar});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colors.surface0,
      appBar: appBar,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36),
                          child: Center(child: formContent),
                        ),
                      ),
                      Container(
                        height: 68,
                        color: colors.surface0,
                        padding: const EdgeInsets.only(
                          top: 26,
                          left: 20,
                          bottom: 26,
                        ),
                        child: Text(
                          '©Mess Messenger 2026',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.text2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class AuthDesktopLayout extends StatelessWidget {
  final Widget formContent;
  final bool isRegisterMode;
  const AuthDesktopLayout({
    super.key,
    required this.isRegisterMode,
    required this.formContent,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    double sectionWidth = (MediaQuery.sizeOf(context).width / 2) * 0.5;

    if (isRegisterMode) {
      return Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: colors.surface0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 32.0, top: 32.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/mess_logo.svg',
                                height: 34,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Mess Messenger',
                                style: textTheme.headlineLarge?.copyWith(
                                  color: colors.text1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: sectionWidth),
                          child: formContent,
                        ),
                      ),
                    ),

                    Container(
                      height: 68,
                      color: colors.surface0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 26.0,
                          left: 32.0,
                          bottom: 26.0,
                        ),
                        child: Text(
                          '©Mess Messenger 2026',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.text2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32.0),
                  child: Image.asset(
                    'assets/images/signup_image.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      sectionWidth = (MediaQuery.sizeOf(context).width / 3);

      return Scaffold(
        body: Container(
          color: colors.surface0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: sectionWidth),
                    child: formContent,
                  ),
                ),
              ),

              Container(
                height: 68,
                color: colors.surface0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 26.0,
                    left: 32.0,
                    bottom: 26.0,
                  ),
                  child: Text(
                    '©Mess Messenger 2026',
                    style: textTheme.bodyMedium?.copyWith(color: colors.text2),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

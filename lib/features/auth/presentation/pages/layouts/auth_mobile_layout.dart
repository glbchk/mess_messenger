import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class AuthMobileLayout extends StatelessWidget {
  final Widget formContent;
  final bool isRegisterMode;
  const AuthMobileLayout({
    super.key,
    required this.isRegisterMode,
    required this.formContent,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    if (isRegisterMode) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: colors.surface0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SvgPicture.asset('assets/icons/mess_logo.svg', height: 40),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: colors.surface2,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Container(
                      color: colors.surface0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 36.0,
                              ),
                              child: Center(child: formContent),
                            ),
                          ),
                          Container(
                            height: 68,
                            color: colors.surface0,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 26.0,
                                left: 20.0,
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
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          color: colors.surface0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.0),
                  child: Center(child: formContent),
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

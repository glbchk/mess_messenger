import 'package:flutter/material.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/subscription_plan_card.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SubscriptionPlanSelector extends StatelessWidget {
  final int selectedPlanIndex;
  final VoidCallback onTapFree;
  final VoidCallback onTapBasic;
  final VoidCallback onTapPro;
  // final VoidCallback onPressedLearnMore;

  const SubscriptionPlanSelector({
    super.key,
    required this.selectedPlanIndex,
    required this.onTapFree,
    required this.onTapBasic,
    required this.onTapPro,
    // required this.onPressedLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);

    return bp.screenWidth < 810
        ? Column(
            spacing: 32,
            children: [
              SubscriptionPlanCard(
                value: selectedPlanIndex == 0,
                onTap: onTapFree,
                label: 'Free',
                description: 'Limited features for individuals.',
                onPressedLearnMore: () {},
              ),
              SubscriptionPlanCard(
                value: selectedPlanIndex == 1,
                onTap: onTapBasic,
                label: 'Free',
                price: 10,
                description: 'Limited features for individuals.',
                onPressedLearnMore: () {},
              ),
              SubscriptionPlanCard(
                value: selectedPlanIndex == 2,
                onTap: onTapPro,
                label: 'Free',
                price: 24,
                description: 'Limited features for individuals.',
                onPressedLearnMore: () {},
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 32,
            children: [
              Expanded(
                flex: 1,
                child: SubscriptionPlanCard(
                  value: selectedPlanIndex == 0,
                  onTap: onTapFree,
                  label: 'Free',
                  description: 'Limited features for individuals.',
                  onPressedLearnMore: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: SubscriptionPlanCard(
                  value: selectedPlanIndex == 1,
                  onTap: onTapBasic,
                  label: 'Free',
                  price: 10,
                  description: 'Limited features for individuals.',
                  onPressedLearnMore: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: SubscriptionPlanCard(
                  value: selectedPlanIndex == 2,
                  onTap: onTapPro,
                  label: 'Free',
                  price: 24,
                  description: 'Limited features for individuals.',
                  onPressedLearnMore: () {},
                ),
              ),
            ],
          );

    //   Column(
    //   spacing: 32,
    //   children: [
    //     SubscriptionPlanCard(
    //       value: selectedPlanIndex == 0,
    //       onTap: onTapFree,
    //       label: 'Free',
    //       description: 'Limited features for individuals.',
    //       onPressedLearnMore: () {},
    //     ),
    //     SubscriptionPlanCard(
    //       value: selectedPlanIndex == 1,
    //       onTap: onTapBasic,
    //       label: 'Basic',
    //       price: 10,
    //       description: 'Limited features for individuals.',
    //       onPressedLearnMore: () {},
    //     ),
    //     SubscriptionPlanCard(
    //       value: selectedPlanIndex == 2,
    //       onTap: onTapPro,
    //       label: 'Pro',
    //       price: 24,
    //       description: 'Limited features for individuals.',
    //       onPressedLearnMore: () {},
    //     ),
    //   ],
    // );
  }
}

import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_widgets/subscription_plan_card.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SubscriptionPlanSelector extends StatelessWidget {
  final AppLocalizations l10n;
  final UserModel? userData;
  final SubscriptionPlan selectedPlan;
  final VoidCallback onTapFree;
  final VoidCallback onTapBasic;
  final VoidCallback onTapPro;
  // final VoidCallback onPressedLearnMore;

  const SubscriptionPlanSelector({
    super.key,
    required this.l10n,
    required this.userData,
    required this.selectedPlan,
    required this.onTapFree,
    required this.onTapBasic,
    required this.onTapPro,
    // required this.onPressedLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);

    final selectedPlan = userData?.subscriptionPlan;

    return bp.screenWidth < 810
        ? Column(
            spacing: 32,
            children: [
              SubscriptionPlanCard(
                value: selectedPlan == SubscriptionPlan.free,
                onTap: onTapFree,
                label: l10n.free,
                description: l10n.freePlanDescription,
                onPressedLearnMore: () {},
              ),
              SubscriptionPlanCard(
                value: selectedPlan == SubscriptionPlan.basic,
                onTap: onTapBasic,
                label: l10n.basic,
                description: l10n.basicPlanDescription,
                price: 10,
                onPressedLearnMore: () {},
              ),
              SubscriptionPlanCard(
                value: selectedPlan == SubscriptionPlan.pro,
                onTap: onTapPro,
                label: l10n.pro,
                description: l10n.proPlanDescription,
                price: 24,
                onPressedLearnMore: () {},
              ),
            ],
          )
        : Row(
            crossAxisAlignment: .center,
            spacing: 32,
            children: [
              Expanded(
                flex: 1,
                child: SubscriptionPlanCard(
                  value: selectedPlan == SubscriptionPlan.free,
                  onTap: onTapFree,
                  label: l10n.free,
                  description: l10n.freePlanDescription,
                  onPressedLearnMore: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: SubscriptionPlanCard(
                  value: selectedPlan == SubscriptionPlan.basic,
                  onTap: onTapBasic,
                  price: 10,
                  label: l10n.basic,
                  description: l10n.basicPlanDescription,
                  onPressedLearnMore: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: SubscriptionPlanCard(
                  value: selectedPlan == SubscriptionPlan.pro,
                  onTap: onTapPro,
                  price: 24,
                  label: l10n.pro,
                  description: l10n.proPlanDescription,
                  onPressedLearnMore: () {},
                ),
              ),
            ],
          );
  }
}

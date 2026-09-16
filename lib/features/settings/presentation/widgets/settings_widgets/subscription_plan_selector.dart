import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/subscription_plan_card.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/ui_helpers/method_helpers.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SubscriptionPlanSelector extends ConsumerWidget {
  const SubscriptionPlanSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bp = ResponsiveBreakpoints.of(context);
    final isWide = bp.isDesktop || bp.isTablet;

    final l10n = context.l10n;
    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');

    final selectedPlan = userData.subscriptionPlan;

    return Flex(
      direction: isWide ? .horizontal : .vertical,
      crossAxisAlignment: .start,
      spacing: 32,
      children: [
        context.flexChild(
          isWide,
          SubscriptionPlanCard(
            value: selectedPlan == SubscriptionPlan.free,
            onTap: () {
              ref
                  .read(userNotifierProvider.notifier)
                  .updateSubscriptionPlan(SubscriptionPlan.free);
            },
            label: l10n.free,
            description: l10n.freePlanDescription,
            onPressedLearnMore: () {},
          ),
        ),
        context.flexChild(
          isWide,
          SubscriptionPlanCard(
            value: selectedPlan == SubscriptionPlan.basic,
            onTap: () {
              ref
                  .read(userNotifierProvider.notifier)
                  .updateSubscriptionPlan(SubscriptionPlan.basic);
            },
            price: 10,
            label: l10n.basic,
            description: l10n.basicPlanDescription,
            onPressedLearnMore: () {},
          ),
        ),
        context.flexChild(
          isWide,
          SubscriptionPlanCard(
            value: selectedPlan == SubscriptionPlan.pro,
            onTap: () {
              ref
                  .read(userNotifierProvider.notifier)
                  .updateSubscriptionPlan(SubscriptionPlan.pro);
            },
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

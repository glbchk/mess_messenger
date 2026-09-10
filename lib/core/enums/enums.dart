enum ShellTab {
  chats(isPushed: false),
  calls(isPushed: false),
  contacts(isPushed: false),
  settings(isPushed: true);

  final bool isPushed;
  const ShellTab({required this.isPushed});
}

enum SubscriptionPlan { free, basic, pro }

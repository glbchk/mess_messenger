const kFaqBotSenderId = 'faq_bot';

class SupportFaqItem {
  final String id;
  final String question;
  final String answer;

  const SupportFaqItem({
    required this.id,
    required this.question,
    required this.answer,
  });
}

const supportFaqList = <SupportFaqItem>[
  SupportFaqItem(
    id: 'restore_conversation',
    question: 'How to restore a deleted conversation?',
    answer:
        'Deleted conversations stay recoverable for 30 days. Go to '
        'Settings → Chats → Recently deleted to restore one.',
  ),
  SupportFaqItem(
    id: 'account_locked',
    question: 'Why is my account locked?',
    answer:
        'Accounts lock after several failed login attempts. Reset your '
        'password from the login screen to unlock it immediately.',
  ),
  SupportFaqItem(
    id: 'refund_request',
    question: 'How do I request a refund?',
    answer:
        'Go to Billing → Subscription → Request refund. Approved refunds '
        'are processed within 5–7 business days.',
  ),
];

SupportFaqItem? findMatchingFaq(String query) {
  final normalized = query.toLowerCase();
  for (final item in supportFaqList) {
    final keywords = item.question
        .toLowerCase()
        .split(RegExp(r'[^a-z0-9]+'))
        .where((w) => w.length > 3);
    if (keywords.any(normalized.contains)) return item;
  }
  return null;
}

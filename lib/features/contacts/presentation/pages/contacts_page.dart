import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/layouts/contacts_desktop_layout.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/layouts/contacts_mobile_layout.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/layouts/contacts_tablet_layout.dart';

class ContactsPage extends ConsumerStatefulWidget {
  const ContactsPage({super.key});

  @override
  ConsumerState<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends ConsumerState<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ContactsMobileLayout(onPressed: () {}),
      tablet: ContactsTabletLayout(onPressed: () {}),
      desktop: ContactsDesktopLayout(onPressed: () {}),
    );
  }
}

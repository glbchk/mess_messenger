import 'package:flutter/material.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_tabs/files_tab_widget.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_tabs/groups_tab_widget.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_tabs/links_tab_widget.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_tabs/media_tab_widget.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_tabs/overview_tab_widget.dart';

class ContactsTabsWidget extends StatelessWidget {
  final TabController tabController;
  final String contactUserId;

  const ContactsTabsWidget({
    super.key,
    required this.tabController,
    required this.contactUserId,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,

      children: [
        OverviewTabWidget(contactUserId: contactUserId),
        MediaTabWidget(contactUserId: contactUserId),
        LinksTabWidget(contactUserId: contactUserId),
        FilesTabWidget(contactUserId: contactUserId),
        GroupsTabWidget(contactUserId: contactUserId),
      ],
    );
  }
}

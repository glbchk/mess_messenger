class ContactsState {
  final String? selectedContactId;

  const ContactsState({this.selectedContactId});

  ContactsState copyWith({
    String? selectedContactId,
    bool clearSelection = false,
  }) {
    return ContactsState(
      selectedContactId: clearSelection
          ? null
          : selectedContactId ?? this.selectedContactId,
    );
  }
}

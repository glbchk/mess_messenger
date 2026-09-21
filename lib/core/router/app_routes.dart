class AppRoutes {
  static const String auth = '/auth';
  static const String root = '/';
  static const String chats = '/chats';
  static const String calls = '/calls';
  static const String contacts = '/contacts';
  static const String settings = '/settings';
  static const String settingsGeneral = '/settings/general';
  static const String settingsTab = '/settings/:tab';
  static const String support = '/support';
  static const String chatDetail = '/chats/:chatId';
  static String chatWith(String chatId) => '/chats/$chatId';
  static String chatsWithSelection(String chatId) => '/chats?c=$chatId';
  static const String profileDetails = '/profile-details/:chatId';
  static String profileDetailsFor(String chatId) => '/profile-details/$chatId';

  static String settingsWithTab(String tab) => '/settings/$tab';
  static const userSearch = '/search';
  static String contactsWithSelection(String chatId) => '/contacts?c=$chatId';
}

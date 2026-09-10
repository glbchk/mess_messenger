String directChatId(String uidA, String uidB) {
  final ids = [uidA, uidB]..sort();
  return '${ids[0]}_${ids[1]}';
}

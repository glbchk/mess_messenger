import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/services/metadata_service.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

final metadataServiceProvider = Provider<MetadataService>((ref) {
  return MetadataService();
});

final linkMetadataProvider = FutureProvider.family<Metadata?, String>((
  ref,
  url,
) {
  return ref.watch(metadataServiceProvider).fetchLinkMetadata(url);
});

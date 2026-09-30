import 'package:flutter/material.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

class MetadataService {
  Future<Metadata?> fetchLinkMetadata(String url) async {
    final proxied =
        'https://link-preview-proxy.glegalchenko.workers.dev/?url=${Uri.encodeComponent(url)}';
    try {
      final data = await MetadataFetch.extract(proxied);
      return data;
    } catch (e) {
      debugPrint('META ERROR [$url]: $e');
      return null;
    }
  }
}

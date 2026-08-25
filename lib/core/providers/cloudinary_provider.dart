import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/services/cloudinary_service.dart';

final cloudinaryServiceProvider = Provider<CloudinaryService>((ref) {
  return CloudinaryService();
});

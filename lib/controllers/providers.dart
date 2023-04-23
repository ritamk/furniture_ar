import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture_ar/controllers/auth_controller.dart';

final Provider<AuthenticationController> authControllerProvider =
    Provider<AuthenticationController>((ref) => AuthenticationController());

final StreamProvider<User?> authStateChangeStreamProvider =
    StreamProvider<User?>(
        (ref) => ref.read(authControllerProvider).authStateChanges);

final StateProvider<String?> userUidProvider = StateProvider<String?>((ref) {
  return ref.read(authControllerProvider).userUid;
});

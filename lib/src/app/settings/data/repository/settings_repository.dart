import 'package:cloud_firestore/cloud_firestore.dart';

final class SettingsRepository {
  const SettingsRepository({
    required this.firebaseFirestore,
  });
  final FirebaseFirestore firebaseFirestore;
}

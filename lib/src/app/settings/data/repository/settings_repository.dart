import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_and_guess/src/core/service/logger.dart';
import 'package:draw_and_guess/src/core/util/constants.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/util/types.dart';

final _legalCache = <String, CachedData<String>>{};

enum LegalType {
  privacy('privacy_policy'),
  terms('terms_of_service');

  const LegalType(this.id);
  final String id;
}

final class SettingsRepository {
  const SettingsRepository({
    required this.firebaseFirestore,
  });
  static const _logger = Logger('SettingsRepository');

  final FirebaseFirestore firebaseFirestore;

  Future<String> getLegalDoc(LegalType type) async {
    try {
      _logger.request('Getting legal doc - ${type.name}');
      if (_legalCache[type.name] != null && _legalCache[type.name]!.expiry.isNotExpired) {
        _logger.request('Doc available in cache');
        return Future.value(_legalCache[type.name]!.data);
      }
      final doc = await firebaseFirestore
          .collection('_legal')
          .doc(type.id)
          .get()
          .then((value) => value.get('text') as String);

      _legalCache[type.name] = (
        data: doc,
        expiry: DateTime.now().add(const Duration(minutes: 30)),
      );
      return doc;
    } catch (e, s) {
      _logger.error('getLegalDoc - $e', stack: s);
      return switch (type) {
        LegalType.privacy => Constants.privacy,
        LegalType.terms => Constants.termsOfService
      };
    }
  }
}

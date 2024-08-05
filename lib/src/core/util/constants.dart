import 'package:flutter/material.dart';
import 'package:skribla/src/app/game/data/models/word_model.dart';

abstract class Constants {
  static const points = 10;
  static const email = 'skriblaapp@gmail.com';
  static final colors = [...Colors.primaries];
  static final allColors = [...Colors.primaries, ...Colors.accents];
  static const words = [
    WordModel(
      id: '1',
      text: 'Apple',
    ),
    WordModel(
      id: '2',
      text: 'Car',
    ),
    WordModel(
      id: '3',
      text: 'Laptop',
    ),
    WordModel(
      id: '4',
      text: 'Headphone',
    ),
  ];

  /// has to be updated like this else it looses it's formatting
  /// ```
  /// FirebaseFirestore.instance
  ///     .collection('_legal')
  ///     .doc(LegalType.privacy.id)
  ///     .set({'text': Constants.privacy});
  /// ```
  static const privacy = '''
At Read, owned by Ifeanyi Onuoha, we value your privacy. This Privacy Policy ("Policy") describes how we collect, use, and share your personal information when you use Read mobile application ("Service"). By using our Service, you agree to the terms of this Policy.

Information We Collect:
We collect telemetry information to improve our product for our users. This data includes, but is not limited to, usage patterns, device information, and user interactions within our Service.

Your information is used to:
  - Improve and optimize our Service.
  - Understand user behavior and preferences.
  - Address technical issues and provide support.

Third-Party Services:
We utilize third-party services to facilitate our data collection and analysis. These third parties include Mixpanel. These services may have their own privacy policies, and we encourage you to review them.

Security:
We value your trust in providing us with your information, and we strive to use commercially acceptable means to protect it. However, no method of electronic storage or transmission is 100% secure, so we cannot guarantee absolute security.

Changes to this Policy:
We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. Changes are effective once they are posted on this page.

Contact Us:
If you have questions or concerns about our Privacy Policy, please contact us at: readappeng@gmail.com

© 2024 Ifeanyi Onuoha. All rights reserved.
''';

  /// has to be updated like this else it looses it's formatting
  /// ```
  /// FirebaseFirestore.instance
  ///     .collection('_legal')
  ///     .doc(LegalType.terms.id)
  ///     .set({'text': Constants.termsOfService});
  /// ```
  static const termsOfService = '''
Last updated: August 04, 2024

Thank you for choosing Read, owned by Ifeanyi Onuoha ("we", "us", "our"). Please read these Terms of Service ("Terms") carefully before using the Read mobile application ("Service"). By accessing or using our Service, you agree to be bound by these Terms.

Acceptance of Terms:
By accessing or using our Service, you confirm your agreement to be bound by these Terms. If you do not agree to these Terms, please do not use our Service.

Changes to Terms:
We may modify these Terms at any time, and such modifications will be effective immediately upon posting the modified Terms on our Service. You agree to review the Terms periodically to be aware of such modifications and your continued access or use of the Service shall be deemed your conclusive acceptance of the modified Terms.

Privacy and Data Collection:
We respect the privacy of our users. We collect telemetry information for the purposes of improving our product for our users. This data is collected through third-party services including Mixpanel. For more information, please refer to our Privacy Policy.

Limitations of Liability:
We shall not be responsible or liable for any direct, indirect, incidental, consequential or exemplary losses or damages that may be incurred by you as a result of using our Service, or as a result of any changes, data loss or corruption, cancellation, loss of access, or downtime.

Termination:
We may terminate or suspend your access to our Service immediately, without prior notice or liability, for any reason, including without limitation if you breach these Terms. All provisions of the Terms which by their nature should survive termination shall survive termination.

Contact Us:
If you have questions or concerns about our Terms of Service, please contact us at: readappeng@gmail.com

© 2024 Ifeanyi Onuoha. All rights reserved.
''';
}

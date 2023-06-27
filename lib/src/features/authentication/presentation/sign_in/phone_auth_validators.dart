import 'package:mobile_shop/src/localization/string_hardcoded.dart';

import 'string_validators.dart';

/// Mixin class to be used for client-side email & password validation
mixin PhoneValidators {
  final StringValidator phoneSubmitValidator = PhoneSubmitRegexValidator();

  bool canSubmitPhone(String phone) {
    return phoneSubmitValidator.isValid(phone);
  }

  String? phoneErrorText(String phone) {
    final bool showErrorText = !canSubmitPhone(phone);
    final String errorText = phone.isEmpty
        ? 'Phone can\'t be empty'.hardcoded
        : 'Invalid phone'.hardcoded;
    return showErrorText ? errorText : null;
  }
}

import 'package:flutter/material.dart';

class SharedPrefKeys {
  static const String refreshToken = 'refreshToken';
  static const String accessToken = 'accessToken';
  static const String parentId = 'parentId';
}

bool isParentLoggedIn = false;

/// Helper class for RTL text direction handling
class RTLHelper {
  /// Determines if text should be LTR even in RTL context
  /// Used for numbers, emails, phone numbers, URLs, etc.
  static TextDirection getTextDirection(String text, {bool forceRTL = false}) {
    if (forceRTL) return TextDirection.rtl;

    // Check if text contains Latin characters (numbers, email, phone)
    final latinPattern = RegExp(r'^[a-zA-Z0-9@._+\-\s]*$');
    if (latinPattern.hasMatch(text)) {
      return TextDirection.ltr;
    }

    // Check if text is primarily Arabic
    final arabicPattern = RegExp(r'[\u0600-\u06FF]');
    if (arabicPattern.hasMatch(text)) {
      return TextDirection.rtl;
    }

    // Default to LTR for mixed or unknown content
    return TextDirection.ltr;
  }

  /// Returns true if the current locale should use RTL layout
  static bool isRTL(BuildContext context) {
    return Directionality.of(context) == TextDirection.rtl;
  }

  /// Returns proper text alignment based on content and locale
  static TextAlign getTextAlign(String text, BuildContext context,
      {TextAlign? override}) {
    if (override != null) return override;

    final isRTLContext = isRTL(context);
    final textDirection = getTextDirection(text);

    if (textDirection == TextDirection.ltr) {
      return TextAlign.left;
    } else {
      return isRTLContext ? TextAlign.right : TextAlign.left;
    }
  }
}

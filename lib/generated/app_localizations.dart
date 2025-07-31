import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  String get app_name;
  String get hello;
  String get welcome;
  String get log_in;
  String get email;
  String get password;
  String get forgot_password;
  String get reset_password;
  String get confirm_password;
  String get old_password;
  String get new_password;
  String get enter_email;
  String get enter_password;
  String get enter_old_password;
  String get enter_new_password;
  String get confirm_new_password;
  String get account;
  String get user_information;
  String get change_password;
  String get tuition_fees;
  String get notifications;
  String get log_out;
  String get family_name;
  String get first_name;
  String get last_name;
  String get birthday;
  String get gender;
  String get address;
  String get phone;
  String get email_address;
  String get level;
  String get announcement;
  String get schedule;
  String get marks;
  String get home_work;
  String get absence;
  String get daily_schedule;
  String get exam_schedule;
  String get schedule_not_available;
  String get total_due;
  String get total_to_pay;
  String get next_amount_to_pay;
  String get next_date_to_pay;
  String get next_amount_to_pay_label;
  String get next_date_to_pay_label;
  String get unknown_student;
  String get no_payment_information;
  String get payment_error;
  String get day;
  String get days;
  String get dzd;
  String get cancel;
  String get edit;
  String get no_data;
  String get retry;
  String get cannot_be_empty;
  String get valid_email;
  String get password_min_length;
  String get no_homework;
  String get change_language;
  String get select_language;
  String get english;
  String get francais;
  String get logout_confirmation;
  String get yes;
  String get no;
  String get close;
  String get subject;
  String get year;
  String get average;
  String get grade;

  String get invalid_email;

  String get please_enter_credentials;

  String get send_code;

  String get confirm;

  String get verification_code;

  String get passwords_do_not_match;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

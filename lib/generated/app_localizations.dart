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

  String get appName;
  String get hello;
  String get welcomeBack;
  String get welcome;
  String get logIn;
  String get email;
  String get password;
  String get forgotPassword;
  String get resetPassword;
  String get confirmPassword;
  String get oldPassword;
  String get newPassword;
  String get enterEmail;
  String get enterPassword;
  String get enterOldPassword;
  String get enterNewPassword;
  String get confirmNewPassword;
  String get account;
  String get userInformation;
  String get changePassword;
  String get tuitionFees;
  String get notifications;
  String get logOut;
  String get familyName;
  String get firstName;
  String get lastName;
  String get birthday;
  String get gender;
  String get address;
  String get phone;
  String get emailAddress;
  String get level;
  String get announcement;
  String get schedule;
  String get marks;
  String get homeWork;
  String get absence;
  String get dailySchedule;
  String get examSchedule;
  String get scheduleNotAvailable;
  String get totalDue;
  String get totalToPay;
  String get nextAmountToPay;
  String get nextDateToPay;
  String get nextAmountToPayLabel;
  String get nextDateToPayLabel;
  String get unknownStudent;
  String get noPaymentInformation;
  String get paymentError;
  String get day;
  String get days;
  String get dzd;
  String get cancel;
  String get edit;
  String get noData;
  String get retry;
  String get cannotBeEmpty;
  String get validEmail;
  String get passwordMinLength;
  String get noHomework;
  String get changeLanguage;
  String get selectLanguage;
  String get english;
  String get francais;
  String get logoutConfirmation;
  String get yes;
  String get no;
  String get close;
  String get subject;
  String get year;
  String get average;
  String get grade;

  String get invalidEmail;

  String get pleaseEnterCredentials;

  String get sendCode;

  String get confirm;

  String get verificationCode;

  String get passwordsDoNotMatch;

  String get passwordChangedSuccessfully;

  String get currentPassword;

  String get currentPasswordRequired;

  String get newPasswordRequired;

  String get confirmPasswordRequired;

  String get passwordMinSixCharacters;

  String get trimestre;

  String get fundamentalAverage;

  String get numberOfAbsence;

  String get reasonOfAbsenceRequired;

  String get addPhoto;

  String get submit;

  String get maxImagesAllowed;

  String get limitReachedMessage;

  String get unknownSubject;

  String get reasonOfAbsence;

  String get nothingToJustify;

  String get sending;

  String get justificationSent;

  String get arabic;

  String get french;

  String get languageChanged;

  String get languageChangeRestart;
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

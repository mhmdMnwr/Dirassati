import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en')) {
    _loadSavedLanguage();
  }

  static const String languageKey = 'language_code';

  void _loadSavedLanguage() async {
    final savedLanguage = await SharedPrefHelper.getString(languageKey);
    if (savedLanguage.isNotEmpty) {
      emit(Locale(savedLanguage));
    }
  }

  void changeLanguage(Locale locale) async {
    emit(locale);
    await SharedPrefHelper.setData(languageKey, locale.languageCode);
  }
}

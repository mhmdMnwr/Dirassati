import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/core/language/language_cubit.dart';
import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeLanguage {
  static void showLanguageSelection(BuildContext context) {
    final isRTL = RTLHelper.isRTL(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            AppLocalizations.of(context)!.selectLanguage,
            style: TextStyles.font18DarkBlueBold,
            textAlign: isRTL ? TextAlign.right : TextAlign.left,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              _buildLanguageOption(
                context: context,
                language: AppLocalizations.of(context)!.english,
                locale: const Locale('en'),
                flag: '🇺🇸',
              ),
              const Divider(),
              _buildLanguageOption(
                context: context,
                language: AppLocalizations.of(context)!.arabic,
                locale: const Locale('ar'),
                flag: '🇸🇦',
              ),
              const Divider(),
              _buildLanguageOption(
                context: context,
                language: AppLocalizations.of(context)!.french,
                locale: const Locale('fr'),
                flag: '🇫🇷',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyles.font14GrayRegular,
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildLanguageOption({
    required BuildContext context,
    required String language,
    required Locale locale,
    required String flag,
  }) {
    final isRTL = RTLHelper.isRTL(context);

    return InkWell(
      onTap: () => _changeLanguage(context, locale),
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.w, // Consistent padding for all options
        ),
        child: Row(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Text(
              flag,
              style: TextStyle(fontSize: 24.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                language,
                style: TextStyles.font14DarkBlueMedium,
                textAlign: isRTL ? TextAlign.right : TextAlign.left,
              ),
            ),
            Icon(
              Icons.language,
              color: ColorsManager.mainBlue,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  static void _changeLanguage(BuildContext context, Locale locale) async {
    Navigator.of(context).pop(); // Close the dialog first

    try {
      // Try to use LanguageCubit if available
      final languageCubit = context.read<LanguageCubit>();
      languageCubit.changeLanguage(locale);

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.languageChanged,
              textDirection: TextDirection
                  .ltr, // Keep success message in LTR for consistency
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Force immediate navigation refresh to apply language changes
        // Navigate to login and then back to trigger full app rebuild
        Future.delayed(const Duration(milliseconds: 500), () {
          if (context.mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.chooseSonScreen,
              (route) => false,
            );
          }
        });
      }
    } catch (e) {
      // Fallback to SharedPreferences if LanguageCubit is not available
      await SharedPrefHelper.setData('language_code', locale.languageCode);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.languageChangeRestart,
              textDirection: TextDirection.ltr, // Keep system messages in LTR
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Force app restart after language change
        Future.delayed(const Duration(seconds: 1), () {
          if (context.mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.loginScreen,
              (route) => false,
            );
          }
        });
      }
    }
  }
}

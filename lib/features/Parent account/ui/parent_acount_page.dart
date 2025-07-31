import 'package:dirasati/core/di/dependency_injection.dart';
import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/language/language_cubit.dart';
import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/core/widgets/confirm_logout.dart';
import 'package:dirasati/features/Parent account/ui/widget/account_header.dart';
import 'package:dirasati/features/Parent account/ui/widget/account_option.dart';
import 'package:dirasati/features/change%20password/logic/cubit/change_password_cubit.dart';
import 'package:dirasati/features/change%20password/ui/change_password.dart';
import 'package:dirasati/features/choose son/data/model/get_me_response.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:dirasati/features/parent%20info/logic/cubit/update_parent_cubit.dart';
import 'package:dirasati/features/parent%20info/ui/parent_inforamtion_page.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Updated AccountPage with BlocProvider for ParentInfoCubit
class AccountPage extends StatelessWidget {
  final UserData parentModel;

  const AccountPage({super.key, required this.parentModel});

  @override
  Widget build(BuildContext context) {
    context
        .read<NotificationsCubit>()
        .getCountNotifications(); // Fetch notifications count

    return PopScope(
      // Removed onPopInvoked as PopDisposition is undefined
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            _buildOptionsList(context),
          ],
        ),
      ),
    );
  }

  /// SliverAppBar with curved bottom and account header
  Widget _buildAppBar(BuildContext context) {
    final isRTL = RTLHelper.isRTL(context);
    
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: ColorsManager.mainBlue,
      expandedHeight: 300.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24.r),
        ),
      ),
      leading: _backButton(context),
      title: Text(
        AppLocalizations.of(context)!.account,
        style: TextStyles.font22Whitebold,
        textAlign: isRTL ? TextAlign.right : TextAlign.left,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: AccountHeader(
          name: isRTL 
            ? '${parentModel.lastName} ${parentModel.firstName}' // Arabic name order
            : '${parentModel.firstName} ${parentModel.lastName}', // English/French name order
        ),
      ),
    );
  }

  /// List of account options as SliverList
  Widget _buildOptionsList(BuildContext context) {
    final isRTL = RTLHelper.isRTL(context);
    final options = _buildOptions(context);
    
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 16.w, // Consistent horizontal padding
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, index) {
            return Column(
              crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                options[index], // Remove extra padding wrapper
                if (index < options.length - 1)
                  Divider(
                    indent: 16.w, 
                    endIndent: 16.w, 
                    height: 1,
                    thickness: 0.5,
                  ),
              ],
            );
          },
          childCount: options.length,
        ),
      ),
    );
  }

  /// Define the list of options with proper Bloc integration
  List<AccountOption> _buildOptions(BuildContext context) => [
        AccountOption(
          icon: IconsManager.userInformation,
          title: AppLocalizations.of(context)!.user_information,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => BlocProvider(
                create: (context) => getIt<UpdateParentCubit>(),
                child: ParentInformationDialog(
                  parentModel: parentModel,
                ),
              ),
            );
          },
        ),
        AccountOption(
          icon: IconsManager.changePassword,
          title: AppLocalizations.of(context)!.change_password,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => BlocProvider(
                create: (context) => getIt<ChangePasswordCubit>(),
                child: ChangePassword(),
              ),
            );
          },
        ),
        AccountOption(
          icon: IconsManager.tuition,
          title: AppLocalizations.of(context)!.tuition_fees,
          onTap: () {
            context.pushNamed(Routes.paimentPage);
          },
        ),
        AccountOption(
          isNotification: true,
          icon: IconsManager.notifications,
          title: AppLocalizations.of(context)!.notifications,
          onTap: () {
            context.pushNamed(Routes.notificationPage).then((_) {
              context.read<NotificationsCubit>().getCountNotifications();
            });
          },
        ),
        AccountOption(
          icon: IconsManager
              .name, // Using name icon as it's more generic for settings
          title: AppLocalizations.of(context)!.change_language,
          onTap: () => _showLanguageSelection(context),
        ),
        AccountOption(
            icon: IconsManager.logOut,
            title: AppLocalizations.of(context)!.log_out,
            onTap: () => showLogoutConfirmationDialog(
                  context: context,
                  onConfirm: () => _logOut(context),
                )),
      ];

  Widget _backButton(BuildContext context) {
    final isRTL = RTLHelper.isRTL(context);
    
    return IconButton(
      onPressed: () {
        context.read<NotificationsCubit>().getCountNotifications();
        context.pop();
      },
      icon: Transform.flip(
        flipX: isRTL, // Flip back button for RTL
        child: Image.asset(
          IconsManager.backButton,
          height: 40.h,
          width: 40.w,
        ),
      ),
    );
  }

  void _logOut(BuildContext context) async {
    await SharedPrefHelper.clearAllData();
    context.pushNamedAndRemoveUntil(Routes.loginScreen , predicate: (route) => false).then((_) {});
  }

  void _showLanguageSelection(BuildContext context) {
    final isRTL = RTLHelper.isRTL(context);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            AppLocalizations.of(context)!.select_language,
            style: TextStyles.font18DarkBlueBold,
            textAlign: isRTL ? TextAlign.right : TextAlign.left,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
                language: 'العربية',
                locale: const Locale('ar'),
                flag: '🇸🇦',
              ),
              const Divider(),
              _buildLanguageOption(
                context: context,
                language: 'Français',
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

  Widget _buildLanguageOption({
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

  void _changeLanguage(BuildContext context, Locale locale) async {
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
              'Language changed successfully!',
              textDirection: TextDirection.ltr, // Keep success message in LTR for consistency
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
              'Language changed. Restarting app to apply changes...',
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

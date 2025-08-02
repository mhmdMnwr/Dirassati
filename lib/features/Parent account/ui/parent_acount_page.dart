import 'package:dirasati/core/di/dependency_injection.dart';
import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/core/widgets/confirm_logout.dart';
import 'package:dirasati/features/Parent account/ui/widget/account_header.dart';
import 'package:dirasati/features/Parent account/ui/widget/account_option.dart';
import 'package:dirasati/features/Parent%20account/ui/widget/change_language.dart';
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
              crossAxisAlignment:
                  isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
          title: AppLocalizations.of(context)!.userInformation,
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
          title: AppLocalizations.of(context)!.changePassword,
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
          title: AppLocalizations.of(context)!.tuitionFees,
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
              .languages, // Using name icon as it's more generic for settings
          title: AppLocalizations.of(context)!.changeLanguage,
          onTap: () => ChangeLanguage.showLanguageSelection(context),
        ),
        AccountOption(
            icon: IconsManager.logOut,
            title: AppLocalizations.of(context)!.logOut,
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
    context
        .pushNamedAndRemoveUntil(Routes.loginScreen,
            predicate: (route) => false)
        .then((_) {});
  }
}

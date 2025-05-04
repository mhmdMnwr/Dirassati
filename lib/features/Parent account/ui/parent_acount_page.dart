import 'package:dirasati/core/di/dependency_injection.dart';
import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/Parent account/ui/widget/account_header.dart';
import 'package:dirasati/features/Parent account/ui/widget/account_option.dart';
import 'package:dirasati/features/change%20password/logic/cubit/change_password_cubit.dart';
import 'package:dirasati/features/change%20password/ui/change_password.dart';
import 'package:dirasati/features/choose son/data/model/get_me_response.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:dirasati/features/parent%20info/logic/cubit/update_parent_cubit.dart';
import 'package:dirasati/features/parent%20info/ui/parent_inforamtion_page.dart';
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
      title: Text('Account', style: TextStyles.font22Whitebold),
      flexibleSpace: FlexibleSpaceBar(
        background: AccountHeader(
          name: '${parentModel.firstName} ${parentModel.lastName}',
        ),
      ),
    );
  }

  /// List of account options as SliverList
  Widget _buildOptionsList(BuildContext context) {
    final options = _buildOptions(context);
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, index) {
            return Column(
              children: [
                options[index],
                if (index < options.length - 1)
                  Divider(indent: 16.w, endIndent: 16.w, height: 1),
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
          title: 'User Information',
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
          title: 'Change Password',
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
          isNotification: true,
          icon: IconsManager.notifications,
          title: 'Notifications',
          onTap: () {
            context.pushNamed(Routes.notificationPage);
          },
        ),
        AccountOption(
          icon: IconsManager.logOut,
          title: 'Log Out',
          onTap: () => _logOut(context),
        ),
      ];

  Widget _backButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<NotificationsCubit>().getCountNotifications();
        context.pop();
      },
      icon: Image.asset(
        IconsManager.backButton,
        height: 40.h,
        width: 40.w,
      ),
    );
  }

  void _logOut(BuildContext context) {
    SharedPrefHelper.clearAllData();
    context.pushReplacementNamed(Routes.loginScreen).then((_) {
      context.read<NotificationsCubit>().getCountNotifications();
    });
  }
}

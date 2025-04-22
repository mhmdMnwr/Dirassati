import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/Parent%20account/ui/widget/account_header.dart';
import 'package:dirasati/features/Parent%20account/ui/widget/account_option.dart';
import 'package:dirasati/features/choose%20son/data/model/get_me_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountPage extends StatelessWidget {
  final UserData? parentModel;
  const AccountPage({super.key, this.parentModel});

  @override
  Widget build(BuildContext context) {
    // your list of options
    final options = <AccountOption>[
      AccountOption(
        icon: IconsManager.userInformation,
        title: 'User Information',
        onTap: () {},
      ),
      AccountOption(
        icon: IconsManager.changePassword,
        title: 'Change Password',
        onTap: () {},
      ),
      AccountOption(
        icon: IconsManager.notifications,
        title: 'Notifications',
        onTap: () {},
      ),
      AccountOption(
        icon: IconsManager.logOut,
        title: 'Log Out',
        onTap: () => _logOut(context),
      ),
    ];

    return Scaffold(
      // enable Material 3
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // ─────────── SliverAppBar with curved bottom ───────────
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: ColorsManager.mainBlue,
            expandedHeight: 355.h,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24.r),
              ),
            ),
            leading: _leadingIcon(context),
            title: Text('Account', style: TextStyles.font22Whitebold),
            flexibleSpace: FlexibleSpaceBar(
              background: AccountHeader(
                name:
                    '${parentModel?.firstName ?? ''} ${parentModel?.lastName ?? 'User Name'}',
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 16.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) {
                  return Column(
                    children: [
                      options[i],
                      if (i < options.length - 1)
                        Divider(endIndent: 5.w, indent: 5.w, height: 1),
                    ],
                  );
                },
                childCount: options.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _leadingIcon(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Image.asset(
        IconsManager.backButton,
        height: 50.h,
        width: 50.w,
      ),
    );
  }

  void _logOut(BuildContext context) {
    SharedPrefHelper.clearAllData();
    context.pushReplacementNamed(Routes.loginScreen);
  }
}

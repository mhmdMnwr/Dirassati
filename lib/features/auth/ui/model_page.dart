import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/core/widgets/app_text_button.dart';
import 'package:dirasati/features/auth/ui/widgets/login_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModelAuthPage extends StatelessWidget {
  final String image;
  final String pageName;
  final String nextRoute;
  final GlobalKey<FormState> formKey;
  final String buttonText;
  final Widget customField;
  final Function emitTheState;
  final bool forgotPassword;

  const ModelAuthPage({
    super.key,
    required this.image,
    required this.pageName,
    required this.nextRoute,
    this.forgotPassword = false,
    required this.formKey,
    required this.buttonText,
    required this.customField,
    required this.emitTheState,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 65.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Positioned(
                    child: Image.asset(
                      image,
                      width: 400.w,
                      height: 300.h,
                    ),
                  ),
                ]),
                verticalSpace(10.h),
                Center(
                  child: Text(
                    pageName,
                    style: TextStyles.logIn,
                  ),
                ),
                verticalSpace(20),
                Column(
                  children: [
                    customField,

                    verticalSpace(10),
                    if (forgotPassword)
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: TextButton(
                          onPressed: () {
                            context.pushNamed(Routes.forgetScreen);
                          },
                          child: Center(
                            child: Text(
                              'Forgot Password?',
                              style: TextStyles.forgetPassStyle,
                            ),
                          ),
                        ),
                      ),
                    verticalSpace(60),
                    AppTextButton(
                      buttonWidth: 273.w,
                      buttonHeight: 57.h,
                      buttonText: buttonText,
                      textStyle: TextStyles.font24WhiteSemiBold,
                      onPressed: () {
                        validateThenDoLogin(context);
                      },
                    ),
                    // verticalSpace(16),
                    // const TermsAndConditionsText(),
                    // verticalSpace(60),
                    // const DontHaveAccountText(),
                    LoginBlocListener(
                      newRoute: nextRoute,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      emitTheState();
    }
  }
}

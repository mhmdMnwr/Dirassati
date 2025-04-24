import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/features/change%20password/data/model/change_password_request.dart';
import 'package:dirasati/features/change%20password/logic/cubit/change_password_cubit.dart';
import 'package:dirasati/features/change%20password/logic/cubit/change_password_state.dart';
import 'package:dirasati/features/change%20password/ui/widget/confirm_button.dart';
import 'package:dirasati/features/change%20password/ui/widget/passwords_fields_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/styles.dart';

/// A dialog for editing parent information without BLoC.
class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainBlue,
                ),
              ),
            );
          },
          success: (_) {
            Navigator.pop(context); // Close the loading dialog
            Navigator.pop(context); // Close the change password dialog
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password changed successfully.'),
                backgroundColor: Colors.green,
              ),
            );
          },
          error: (error) {
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      },
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Change Password', style: TextStyles.font22BlackBold),
                  verticalSpace(24.h),

                  PasswordsFieldsColumn(
                    confirmPasswordController: _newPasswordController,
                    newPasswordController: _confirmPasswordController,
                    currentPasswordController: _oldPasswordController,
                  ),

                  // Action Buttons
                  ConfirmButton(
                    onSave: () {
                      final changePassword = ChangePasswordRequest(
                        oldPassword: _oldPasswordController.text,
                        newPassword: _newPasswordController.text,
                      );
                      if (_formKey.currentState!.validate()) {
                        context.read<ChangePasswordCubit>().changePassword(
                            changePasswordRequest: changePassword);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

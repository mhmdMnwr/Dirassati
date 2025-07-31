import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/widgets/setup_bloc_states.dart';
import 'package:dirasati/features/parent%20info/data/model/update_parent_request.dart';
import 'package:dirasati/features/parent%20info/logic/cubit/update_parent_cubit.dart';
import 'package:dirasati/features/parent%20info/logic/cubit/update_parent_state.dart';
import 'package:dirasati/features/parent%20info/ui/widget/text_fields.dart';
import 'package:dirasati/features/parent%20info/ui/widget/action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/choose son/data/model/get_me_response.dart';
import 'package:dirasati/generated/app_localizations.dart';

/// A dialog for editing parent information without BLoC.
class ParentInformationDialog extends StatefulWidget {
  final UserData parentModel;
  const ParentInformationDialog({super.key, required this.parentModel});

  @override
  State<ParentInformationDialog> createState() =>
      _ParentInformationDialogState();
}

class _ParentInformationDialogState extends State<ParentInformationDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.parentModel.firstName);
    _lastNameController =
        TextEditingController(text: widget.parentModel.lastName);
    _addressController =
        TextEditingController(text: widget.parentModel.address);
    _phoneController = TextEditingController(text: widget.parentModel.phone);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateParentCubit, UpdateParentState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            SetupLoadingState.show(context);
          },
          success: (getMeResponse) {
            context.pushNamedAndRemoveUntil(
              Routes.chooseSonScreen,
              predicate: (_) => false,
            );
          },
          error: (error) {
            SetupErrorState.show(context, error);
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
                  Text(AppLocalizations.of(context)!.userInformation,
                      style: TextStyles.font22BlackBold),
                  verticalSpace(24.h),

                  TextFieldsColumn(
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                    addressController: _addressController,
                    phoneController: _phoneController,
                  ),

                  // Action Buttons
                  ActionButtons(
                    onSave: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<UpdateParentCubit>().updateParent(
                              updatedParent: _getUpdatedUserData(),
                            );
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

  UpdateParentRequest _getUpdatedUserData() {
    return UpdateParentRequest(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      address: _addressController.text.trim(),
      phone: _phoneController.text.trim(),
    );
  }
}

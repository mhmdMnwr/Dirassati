import 'package:dirasati/core/widgets/setup_bloc_states.dart';
import 'package:dirasati/features/paiment/data/model/paiment_model.dart';
import 'package:dirasati/features/paiment/logic/cubit/paiment_cubit.dart';
import 'package:dirasati/features/paiment/logic/cubit/paiment_state.dart';
import 'package:dirasati/features/paiment/ui/widgets/app_bar.dart';
import 'package:dirasati/features/paiment/ui/widgets/student_list_view_builder.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Assuming you might need this for shimmer or error styling

class PaimentBlocBuilderWidget extends StatelessWidget {
  PaimentBlocBuilderWidget({super.key});

  final List<String> modeType = [
    'loading',
    "success",
    'empty',
    'error',
  ];

  Widget _blocElement(
      {required BuildContext context,
      PaimentResponse? paiment,
      String? errorMessage,
      required String mode}) {
    if (mode == modeType[1]) {
      return Column(
        children: [
          PaymentAppBar(
            nextPaymentDate: paiment!.nextPaimnetDateString,
            title: AppLocalizations.of(context)!.tuitionFees,
            daysLeft:
                paiment.daysLeftForNextPaiment, // Example, adjust as needed
            totalToPay:
                '${paiment.totalNotPaidAmount} DZD', // Example, adjust as needed
            nextPaiment: '${paiment.nextPaimentAmount}  DZD',
          ),
          Expanded(
            child: StudentListViewBuilder(
              paiments: paiment.data ?? [], // Ensure data is not null
            ),
          ),
        ],
      );
    } else if (mode == modeType[0]) {
      return Column(
        children: [
          PaymentAppBar(
            nextPaymentDate: '',
            title: AppLocalizations.of(context)!.tuitionFees,
            daysLeft: 0, // Example, adjust as needed
            totalToPay: '_____ DZD', // Example, adjust as needed
            nextPaiment: '0 DZD',
          ),
          Expanded(child: Center(child: SetupLoadingState.build())),
        ],
      ); // Display the payment card
    } else if (mode == modeType[2]) {
      return Column(
        children: [
          PaymentAppBar(
            nextPaymentDate: '',
            title: AppLocalizations.of(context)!.tuitionFees,
            daysLeft: 0, // Example, adjust as needed
            totalToPay: '0 DZD', // Example, adjust as needed
            nextPaiment: '0 DZD',
          ),
          Expanded(
              child: Center(
                  child: Text(
                      AppLocalizations.of(context)!.noPaymentInformation))),
        ],
      );
    } else if (mode == modeType[3]) {
      return Column(
        children: [
          PaymentAppBar(
            nextPaymentDate: '',
            title: AppLocalizations.of(context)!.tuitionFees,
            daysLeft: 0, // Example, adjust as needed
            totalToPay: '0 DZD', // Example, adjust as needed
            nextPaiment: '0 DZD',
          ),
          Expanded(
              child: _setupError(
            context,
            errorMessage ?? AppLocalizations.of(context)!.paymentError,
          )),
        ],
      );
    } else {
      return const SizedBox.shrink(); // Fallback for unexpected mode
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaimentCubit, PaimentState>(
      buildWhen: (previous, current) =>
          current is Loading || current is PaimentLoaded || current is Error,
      builder: (context, state) {
        return state.whenOrNull(
              // Or a placeholder
              loading: () => _blocElement(context: context, mode: modeType[0]),
              paimentLoaded: (paimentResponse) {
                if (paimentResponse.data == null ||
                    paimentResponse.data!.isEmpty) {
                  return _blocElement(
                    context: context,
                    mode: modeType[2],
                  );
                } else {
                  return _blocElement(
                    context: context,
                    paiment: paimentResponse,
                    mode: modeType[1],
                  );
                }
              },
              error: (errorMsg) => _blocElement(
                mode: modeType[3],
                context: context,
                errorMessage: errorMsg,
              ),
            ) ??
            const SizedBox.shrink();
      },
    );
  }

  Widget _setupError(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.paymentError,
              style: TextStyle(color: Colors.red, fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                context.read<PaimentCubit>().getMyPaiment();
              },
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      ),
    );
  }
}

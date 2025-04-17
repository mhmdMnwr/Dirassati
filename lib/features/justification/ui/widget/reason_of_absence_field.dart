import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReasonOfAbsenceField extends StatelessWidget {
  final GlobalKey<FormState> raeasonOfAbsenceKey;
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;

  const ReasonOfAbsenceField({
    super.key,
    this.controller,
    this.hintText = "Enter reason for absence...",
    this.onChanged,
    required this.raeasonOfAbsenceKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 200.h, // Set a maximum height for the field
          ),
          child: Form(
            key: raeasonOfAbsenceKey,
            child: TextFormField(
              controller: controller,
              minLines: 1,
              maxLines: null, // Auto-expands as needed
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: onChanged,
              validator: (value) {
                if (value == null || value.isEmpty || value.trim().isEmpty) {
                  return 'Please enter a reason';
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}

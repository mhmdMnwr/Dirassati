import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpField extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final double fieldWidth;
  final double fieldHeight;
  final double spacing;
  final TextStyle textStyle;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final bool autoFocus;
  final GlobalKey<FormState> verifyFormKey;
  final TextEditingController? parentController;

  const OtpField({
    super.key,
    required this.verifyFormKey,
    this.parentController,
    this.length = 4,
    this.onCompleted,
    this.onChanged,
    this.fieldWidth = 61,
    this.fieldHeight = 80,
    this.spacing = 8,
    this.textStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    this.decoration = const InputDecoration(),
    this.keyboardType = TextInputType.number,
    this.autoFocus = true,
  });

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  String _otpCode = '';

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    _controllers =
        List.generate(widget.length, (index) => TextEditingController());
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleOtpChange() {
    _otpCode = _controllers.map((controller) => controller.text).join();

    if (widget.parentController != null) {
      widget.parentController!.text = _otpCode;
    }

    widget.onChanged?.call(_otpCode);
    if (_otpCode.length == widget.length) {
      widget.onCompleted?.call(_otpCode);
    }
  }

  void _handleFocusChange(int index, String value) {
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: widget.verifyFormKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.length, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
                child: _OtpDigitField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  autoFocus: widget.autoFocus && index == 0,
                  textStyle: widget.textStyle,
                  decoration: widget.decoration,
                  keyboardType: widget.keyboardType,
                  fieldWidth: widget.fieldWidth.w,
                  fieldHeight: widget.fieldHeight.h,
                  onChanged: (value) {
                    _handleOtpChange();
                    _handleFocusChange(index, value);
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _OtpDigitField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autoFocus;
  final TextStyle textStyle;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final double fieldWidth;
  final double fieldHeight;
  final ValueChanged<String> onChanged;

  const _OtpDigitField({
    required this.controller,
    required this.focusNode,
    required this.autoFocus,
    required this.textStyle,
    required this.decoration,
    required this.keyboardType,
    required this.fieldWidth,
    required this.fieldHeight,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fieldWidth,
      height: fieldHeight,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: keyboardType,
        maxLength: 1,
        style: textStyle,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: decoration.copyWith(
          counterText: '',
          contentPadding: EdgeInsets.zero,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          // errorStyle: const TextStyle(height: 0),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            controller.text = value[0];
            onChanged(value[0]);
          } else {
            onChanged('');
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
      ),
    );
  }
}

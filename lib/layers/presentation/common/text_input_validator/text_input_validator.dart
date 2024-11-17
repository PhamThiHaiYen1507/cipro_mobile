import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';

class TextInputValidator extends StatefulWidget {
  final bool? hasBorder;
  final String? label;
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final String? initialText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final GlobalKey<FormFieldState>? fieldKey;
  final Color? errorColor;
  final String? Function(String? value)? validator;
  final bool? obscureText;
  final bool? enabled;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool? hasError;
  final EdgeInsets? contentPadding;
  final void Function(String)? onChanged;
  final BorderRadius borderRadius;
  final Color? borderColor;
  final int? maxLines;
  final int? minLines;

  const TextInputValidator({
    this.hasBorder,
    super.key,
    this.label,
    this.enabled,
    this.initialText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.hintText,
    this.keyboardType,
    this.errorColor,
    this.validator,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.fieldKey,
    this.obscureText,
    this.helperText,
    this.helperStyle,
    this.textAlign,
    this.onChanged,
    this.contentPadding,
    this.hasError,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.style,
    this.borderColor,
    this.errorStyle,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.maxLines = 1,
    this.minLines,
  });

  @override
  State<TextInputValidator> createState() => _TextInputValidatorState();
}

class _TextInputValidatorState extends State<TextInputValidator> {
  late final GlobalKey<FormFieldState> _key;

  late final FocusNode _focusNode;

  late final TextEditingController _controller;

  bool hasError = false;

  @override
  void initState() {
    _key = widget.fieldKey ?? GlobalKey<FormFieldState>();

    _focusNode = widget.focusNode ?? FocusNode();

    _controller =
        widget.controller ?? TextEditingController(text: widget.initialText);

    _focusNode.addListener(_focusListen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      key: _key,
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      scrollPadding: EdgeInsets.zero,
      validator: (value) {
        if (widget.validator == null) return null;
        final error = widget.validator!(value);

        setState(() {
          hasError = error != null;
        });
        return error;
      },
      onChanged: widget.onChanged,
      obscureText: widget.obscureText ?? false,
      textAlign: widget.textAlign ?? TextAlign.start,
      style: widget.style,
      decoration: InputDecoration(
        errorText: (hasError || (widget.hasError ?? hasError))
            ? widget.errorText
            : null,
        hintText: widget.hintText,
        enabled: widget.enabled ?? true,
        helperText: widget.helperText,
        helperStyle: const TextStyle(height: 0.2).merge(widget.helperStyle),
        hintStyle: AppTextStyle.f14R.copyWith(color: AppColors.midGrey),
        errorStyle: TextStyle(
                height: 0.2, color: widget.errorColor ?? AppColors.errorColor)
            .merge(widget.errorStyle),
        contentPadding: widget.contentPadding ?? AppPadding.a8,
        suffixIcon: widget.suffixIcon,
        isDense: true,
        suffixIconConstraints: widget.suffixIconConstraints ??
            const BoxConstraints(
              maxHeight: 34,
              maxWidth: 34,
            ),
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: widget.prefixIconConstraints ??
            const BoxConstraints(
              maxHeight: 34,
              maxWidth: 34,
            ),
        border: normalBorder,
        errorBorder: normalBorder,
        enabledBorder: normalBorder,
        disabledBorder: normalBorder,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: widget.hasBorder == false
                  ? Colors.transparent
                  : hasError
                      ? widget.errorColor ?? AppColors.errorColor
                      : widget.borderColor ?? AppColors.primaryColor),
          borderRadius: widget.borderRadius,
        ),
        fillColor: Colors.white,
        filled: true,
        labelText: widget.label,
        labelStyle: AppTextStyle.f14R.copyWith(color: AppColors.midGrey),
        floatingLabelStyle: AppTextStyle.f12R.copyWith(
          color: widget.hasBorder == false
              ? Colors.transparent
              : hasError
                  ? widget.errorColor ?? AppColors.errorColor
                  : AppColors.primaryColor,
        ),
      ),
      maxLines: widget.maxLines,
      minLines: widget.minLines,
    );
  }

  void _focusListen() {
    if (_focusNode.hasFocus) {
      setState(() {
        hasError = false;
      });

      _key.currentState?.reset();
    } else {
      if (widget.validator == null) return;
      final error = widget.validator!(_controller.text);

      setState(() {
        hasError = error != null;
      });
    }
  }

  OutlineInputBorder get normalBorder => OutlineInputBorder(
        borderSide: BorderSide(
            width: 1,
            color: widget.hasBorder == false
                ? Colors.transparent
                : hasError
                    ? widget.errorColor ?? AppColors.errorColor
                    : widget.borderColor ?? AppColors.inputBorderColor),
        borderRadius: widget.borderRadius,
      );

  @override
  void dispose() {
    _focusNode.removeListener(_focusListen);

    if (widget.focusNode == null) {
      _focusNode.dispose();
    }

    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

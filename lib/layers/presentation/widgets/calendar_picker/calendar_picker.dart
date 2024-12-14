import 'package:base_project/layers/presentation/common/text_input_validator/text_input_validator.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';

class CalendarPicker extends StatefulWidget {
  final DateTime? firstDate;

  final DateTime? lastDate;

  final DateTime? initialDate;

  final String? hintText;

  final void Function(DateTime date) onChanged;

  final String? Function(String? value)? validator;

  final AutovalidateMode? autovalidateMode;

  const CalendarPicker({
    super.key,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.hintText,
    required this.onChanged,
    this.validator,
    this.autovalidateMode,
  });

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  late final TextEditingController controller = TextEditingController(
      text: widget.initialDate != null
          ? Utils.formatDateToDisplay(widget.initialDate)
          : null);

  late DateTime? selectedDateTime = widget.initialDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showDatetime,
      child: TextInputValidator(
        controller: controller,
        enabled: false,
        style: AppTextStyle.f14R,
        hintText: widget.hintText ?? 'dd/MM/yyyy',
        suffixIcon: IconButton(
          onPressed: showDatetime,
          icon: const Icon(
            Icons.calendar_month,
            size: 18,
            color: AppColors.primaryColor,
          ),
        ),
        validator: widget.validator,
      ),
    );
  }

  Future<void> showDatetime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
    );

    if (date != null) {
      setState(() {
        selectedDateTime = date;
        controller.text = Utils.formatDateToDisplay(date);
      });

      widget.onChanged(date);
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}

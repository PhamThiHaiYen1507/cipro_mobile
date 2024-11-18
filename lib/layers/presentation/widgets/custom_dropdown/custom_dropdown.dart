import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/layers/presentation/widgets/custom_tooltip/custom_tooltip.dart';
import 'package:base_project/utils/helpers/app_border_radius.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;

  final BoxDecoration? decoration;

  final Widget Function(T item) itemBuilder;

  final Widget Function(T item)? selectedBuilder;

  final Widget Function()? placeHolderBuilder;

  final void Function(T item)? onSelected;

  final T? selectedItem;

  final bool fitSize;

  final BoxConstraints? constraints;

  final double height;

  final Color? selectedColor;

  final bool useExpand;

  final bool fitScreen;

  const CustomDropdown({
    super.key,
    required this.items,
    this.decoration,
    required this.itemBuilder,
    this.onSelected,
    this.selectedBuilder,
    this.selectedItem,
    this.placeHolderBuilder,
    this.fitSize = false,
    this.constraints,
    this.height = 38,
    this.selectedColor,
    this.useExpand = true,
    this.fitScreen = false,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  late T? selected = widget.selectedItem;

  final CustomToolTipController controller = CustomToolTipController();

  @override
  Widget build(BuildContext context) {
    final isSelected = selected != null;

    return SizedBox(
      height: widget.height,
      child: CustomToolTip(
        fitSize: widget.fitSize,
        fitScreen: widget.fitScreen,
        controller: controller,
        tooltip: Container(
          constraints: widget.constraints,
          decoration: context.defaultBox,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.items
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        controller.close();
                        setState(() {
                          widget.onSelected?.call(e);
                        });
                      },
                      child: widget.itemBuilder(e),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        direction: TooltipDirection.bottom,
        tooltipBottomStart: TooltipBottomStart.right,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: isSelected
                    ? (widget.selectedColor ?? AppColors.primaryColor)
                    : AppColors.inputBorderColor),
            borderRadius: AppBorderRadius.sm,
            color: Colors.white,
          ),
          child: (isSelected
              ? DefaultTextStyle(
                  style: AppTextStyle.f14M.copyWith(
                      color: widget.selectedColor ?? AppColors.primaryColor),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.useExpand)
                        Expanded(
                            child:
                                widget.selectedBuilder?.call(selected as T) ??
                                    widget.itemBuilder(selected as T))
                      else
                        widget.selectedBuilder?.call(selected as T) ??
                            widget.itemBuilder(selected as T),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: isSelected
                            ? (widget.selectedColor ?? AppColors.primaryColor)
                            : Colors.black.withOpacity(0.8),
                      )
                    ],
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.useExpand)
                      Expanded(
                          child: widget.placeHolderBuilder?.call() ??
                              const SizedBox())
                    else
                      widget.placeHolderBuilder?.call() ?? const SizedBox(),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.black.withOpacity(0.8),
                    )
                  ],
                )),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CustomDropdown<T> oldWidget) {
    selected = widget.selectedItem;
    super.didUpdateWidget(oldWidget);
  }
}

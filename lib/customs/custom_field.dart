import 'package:appwise_ecom/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart';
import '../utils/text_utility.dart';

Widget customField({
  Key? key,
  TextEditingController? controller,
  String? hintText,
  String? initialValue,
  double? height,
  TextInputType? keyboardType,
  bool readonly = false,
  String? Function(String?)? validator,
  Widget? suffixIcon,
  Widget? prefixIcon,
  void Function()? onEditingComplete,
  bool? obscureText,
  String? errorText,
  String? labelText,
  List<TextInputFormatter>? inputFormatters,
  void Function(String value)? onChanged,
  VoidCallback? onTap,
  TextStyle? hintTextStyle = const TextStyle(
    color: AppColor.placeholderTextGreyColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    // letterSpacing: 1,
  ),
  TextStyle? textStyle,
  FocusNode? focusNode,
  BorderRadius? borderRadius = const BorderRadius.all(Radius.circular(4)),
  Color? backgroundColor,
  bool skipBackgroundColor = false,
  Border? showBorder,
  Color? color,
  bool filled = true,
  int? maxLength = 80,
  int? maxLines = 1,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? contentPadding = const EdgeInsets.symmetric(
    vertical: 22,
    horizontal: 12,
  ),
  double? width,
  bool enabled = true,
  bool isDense = true,
  final TextCapitalization textCapitalization = TextCapitalization.none,
  Function(dynamic value)? onFieldSubmitted,
  Function()? onTapOutside,
  Iterable<String>? autofillHints,
  BorderSide? borderSide,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: TextFormField(
      style: textStyle,
      textCapitalization: textCapitalization,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      maxLength: maxLength,
      readOnly: readonly,
      initialValue: initialValue,
      enabled: enabled,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
        if (onTapOutside != null) {
          onTapOutside();
        }
      },
      key: key,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      validator: validator,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        errorText: errorText,
        labelText: labelText,
        labelStyle: hintTextStyle,
        isDense: isDense,
        counterText: '',
        fillColor: AppColor.white,
        filled: filled,
        hintText: hintText,
        hintStyle: hintTextStyle,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding,
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
          borderSide: borderSide ??
              BorderSide(
                // color: Color(0xFF25476A),
                color: filled == true ? Colors.white : const Color.fromARGB(255, 152, 162, 173),
                width: filled == true ? 0.8 : 0,
              ),
        ),
        // contentPadding: padding ?? contentPadding ?? const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
          borderSide: const BorderSide(
            width: 0.8,
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

class CustomDropdownFormField<T> extends StatefulWidget {
  final String? label;
  final String placeHolderText;
  final String? hintText;
  final double borderRadius;
  final T? value;
  final List<dynamic> items;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final IconData? righticon;
  final TextStyle? hintStyle;
  final String? title;
  final double labelFontSize;
  final FontWeight? labelFontWeight;
  final bool isMandatory;
  final FocusNode? focusNode;
  final bool disabled;
  final EdgeInsets? margin;
  final dynamic backgroundColor;
  final String? id;

  const CustomDropdownFormField(
      {super.key,
      this.label,
      this.placeHolderText = "Select",
      this.hintText,
      this.borderRadius = 10,
      required this.value,
      this.id,
      required this.items,
      required this.onChanged,
      this.validator,
      this.righticon,
      this.hintStyle = const TextStyle(color: Colors.grey),
      this.title,
      this.labelFontSize = 16,
      this.labelFontWeight,
      this.isMandatory = false,
      this.focusNode,
      this.disabled = false,
      this.margin,
      this.backgroundColor});

  @override
  State<CustomDropdownFormField<T>> createState() => _CustomDropdownFormFieldState<T>();
}

class _CustomDropdownFormFieldState<T> extends State<CustomDropdownFormField<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: Colors.transparent,
        ),
        color: widget.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<T>(
            focusNode: widget.focusNode,
            value: widget.value,
            isExpanded: true,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            // isDense: true,
            style: Theme.of(context).textTheme.labelMedium,
            padding: const EdgeInsets.all(0),
            focusColor: Colors.transparent,
            icon: const Icon(
              Icons.expand_more,
              color: Colors.transparent,
            ),
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
            items: widget.items.map((item) {
              return DropdownMenuItem<T>(
                key: ValueKey(widget.id.toString()),
                value: item,
                child: Text(
                  item[widget.id].toString().capitalizeFirstLetter(),
                  softWrap: true,
                  // textAlign: TextAlign.center,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
            onChanged: widget.disabled ? null : widget.onChanged,
            validator: widget.validator,
            decoration: InputDecoration(
              hoverColor: Colors.transparent,
              suffixIcon: const Icon(Icons.expand_more),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  )),
              errorStyle: const TextStyle(height: 0),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              hintText: null,
              hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700),
              focusColor: Colors.transparent,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  )),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              errorMaxLines: 1,
            ),
            hint: AppText(
              text: widget.placeHolderText,
              fontsize: 12,
              fontWeight: FontWeight.w500,
              textColor: AppColor.placeholderTextGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}

Widget customDropdownField({
  Key? key,
  required List<DropdownMenuItem<String>>? items,
  required void Function(String?)? onChanged,
  String? value,
  void Function()? onTap,
  Widget? hint,
  TextStyle? style,
  Widget? icon,
  Color? iconDisabledColor,
  Color? iconEnabledColor,
  double iconSize = 23.0,
  double height = 40.0,
  bool isDense = true,
  bool isExpanded = false,
  double? itemHeight,
  Color? focusColor,
  FocusNode? focusNode,
  bool autofocus = false,
  Color? dropdownColor = Colors.white,
  InputDecoration? decoration,
  void Function(String?)? onSaved,
  String? Function(String?)? validator,
  AutovalidateMode? autovalidateMode,
  double? menuMaxHeight,
  bool? enableFeedback,
  AlignmentGeometry alignment = AlignmentDirectional.topCenter,
  BorderRadius? borderRadius,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? contentPadding,
  double? width,
}) {
  return Container(
    // margin: ,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.transparent,
      ),
      color: AppColor.textFiedlGreyColor,
    ),
    child: DropdownButtonFormField(
      items: items,
      onChanged: onChanged,
      validator: validator,
      key: key,
      hint: hint,
      value: value,
      isExpanded: true,
      borderRadius: BorderRadius.circular(10),
      // isDense: true,
      focusColor: Colors.transparent,
      // style: style ?? TTextTheme.lightTextTheme.bodyMedium,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF818898),
        fontFamily: 'Poppins',
      ),
      padding: padding,
      icon: icon ?? const Icon(Icons.keyboard_arrow_down),
      iconSize: 23,
      dropdownColor: dropdownColor,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      menuMaxHeight: menuMaxHeight ?? 200.0, // Adjust the height as necessary
    ),
  );
}

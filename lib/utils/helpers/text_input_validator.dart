class TextValidate {
  static String? validateEmpty(String? value, {String? errorText}) =>
      value?.isNotEmpty == true ? null : errorText ?? '';
}

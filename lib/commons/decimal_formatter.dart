import 'package:flutter/services.dart';

class DecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text == ",") {
      return newValue.copyWith(text: ',');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      String newString = format(newValue.text);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndexFromTheRight,
        ),
      );
    } else {
      return newValue;
    }
  }

  String format(String newValue) {
     String clearedText = newValue.replaceAll(dotsAndCommas(), "");
    String newString;
    if (clearedText.length == 1 || clearedText.length == 2) {
      newString = ",$clearedText";
    } else {
      newString = formatToDecimal(clearedText);
    }
    return newString;
  }

  String formatToDecimal(String clearedText) =>
      "${clearedText.substring(0, clearedText.length - 2)},${clearedText.substring(clearedText.length - 2, clearedText.length)}";

  RegExp dotsAndCommas() => RegExp("\\.?,?");
}

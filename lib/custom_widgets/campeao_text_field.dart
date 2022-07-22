import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color/theme_colors.dart';

class CampeaoInputTextField extends StatefulWidget {
  final Function onTextChanged;
  final String? initialText;
  final String? hintText;
  final String? errorText;
  final bool enabled;
  final bool hidePasswordEnabled;
  final bool errorActivated;
  final bool clearText;
  final String? prefixText;
  final IconButton? suffixIconButton;
  final IconButton? prefixIconButton;
  final TextInputType textInputType;
  final List<TextInputFormatter> textInputFormatters;

  const CampeaoInputTextField(
      {Key? key,
      required this.onTextChanged,
      this.hintText,
      this.hidePasswordEnabled = false,
      this.initialText,
      this.enabled = true,
      this.errorText,
      this.errorActivated = false,
      this.prefixIconButton,
      this.suffixIconButton,
      this.clearText = false,
      this.textInputType = TextInputType.text,
      this.textInputFormatters = const [],
      this.prefixText})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CampeaoInputTextFieldState();
}

class _CampeaoInputTextFieldState extends State<CampeaoInputTextField> {
  final FocusNode _textFieldFocusNode = FocusNode();
  Color _backgroundColor = Colors.white;
  final TextEditingController _fieldController = TextEditingController();
  bool _obscureText = false;

  @override
  void initState() {
    setupFocusListener();
    setupObscureText();
    _fieldController.text = widget.initialText ?? "";
    super.initState();
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    _fieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    if (widget.clearText) {
      _fieldController.text = "";
    }
    return SizedBox(
      height: 55,
      child: TextField(
        keyboardType: widget.textInputType,
        inputFormatters: widget.textInputFormatters,
        textAlign: TextAlign.start,
        enabled: widget.enabled,
        controller: _fieldController,
        obscureText: _obscureText,
        focusNode: _textFieldFocusNode,
        style: const TextStyle(
            color: CampeaoColors.primaryTextColor, fontSize: 15),
        decoration: InputDecoration(
            errorText: widget.errorActivated ? widget.errorText : null,
            filled: true,
            fillColor: _backgroundColor,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: CampeaoColors.primaryColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: CampeaoColors.primaryColorDark),
            ),
            border: const OutlineInputBorder(),
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: widget.enabled
                    ? CampeaoColors.primaryColor
                    : CampeaoColors.primaryTextColor),
            prefixIcon: widget.prefixText == null
                ? widget.prefixIconButton
                : Padding(
                    padding: const EdgeInsets.only(left: 5, right: 3),
                    child: Text(
                      widget.prefixText!,
                      style: const TextStyle(color: CampeaoColors.primaryColor),
                    ),
                  ),
            prefixIconConstraints: const BoxConstraints(),
            suffixIcon: widget.hidePasswordEnabled
                ? createSuffixIconHidePassword()
                : widget.suffixIconButton),
        onChanged: (newText) {
          widget.onTextChanged(newText);
        },
      ),
    );
  }

  Widget createSuffixIconHidePassword() {
    return IconButton(
        icon: const Icon(Icons.remove_red_eye_outlined),
        color: widget.enabled
            ? CampeaoColors.primaryColorDark
            : CampeaoColors.primaryTextColor,
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        });
  }

  void setupFocusListener() {
    _textFieldFocusNode.addListener(() {
      setState(() {
        _backgroundColor = _textFieldFocusNode.hasFocus
            ? CampeaoColors.primaryColorSoft
            : Colors.white;
      });
    });
  }

  void setupObscureText() {
    _obscureText = widget.hidePasswordEnabled;
  }
}

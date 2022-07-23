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
  final bool isUnderlined;
  final Color backgroundColor;
  final double fontSize;

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
      this.prefixText,
      this.isUnderlined = false,
      this.backgroundColor = Colors.white,
      this.fontSize = 15})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CampeaoInputTextFieldState();
}

class _CampeaoInputTextFieldState extends State<CampeaoInputTextField> {
  final FocusNode _textFieldFocusNode = FocusNode();
  late Color _backgroundColor;
  final TextEditingController _fieldController = TextEditingController();
  bool _obscureText = false;

  @override
  void initState() {
    _setupFocusListener();
    _setupObscureText();
    _backgroundColor = widget.backgroundColor;
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
        textAlignVertical: TextAlignVertical.center,
        style: _createStyle(),
        decoration: InputDecoration(
            errorText: widget.errorActivated ? widget.errorText : null,
            filled: true,
            fillColor: _backgroundColor,
            enabledBorder: _createEnabledBorder(),
            focusedBorder: _createFocusedBorder(),
            border: _createBorder(),
            hintText: widget.hintText,
            hintStyle: _createHintStyle(),
            prefixIcon: _createPrefixIcon(),
            prefixIconConstraints: const BoxConstraints(),
            suffixIcon: _createSuffixIcon()),
        onChanged: (newText) {
          widget.onTextChanged(newText);
        },
      ),
    );
  }

  TextStyle _createStyle() {
    return TextStyle(
          color: CampeaoColors.primaryTextColor, fontSize: widget.fontSize);
  }

  Widget? _createSuffixIcon() {
    return widget.hidePasswordEnabled
              ? _createSuffixIconHidePassword()
              : widget.suffixIconButton;
  }

  Widget? _createPrefixIcon() {
    return widget.prefixText == null
              ? widget.prefixIconButton
              : Padding(
                  padding: const EdgeInsets.only(left: 5, right: 3),
                  child: Text(
                    widget.prefixText!,
                    style: TextStyle(color: widget.enabled
                        ? CampeaoColors.primaryColor
                        : CampeaoColors.primaryTextColor),
                  ),
                );
  }

  TextStyle _createHintStyle() {
    return TextStyle(
              color: widget.enabled
                  ? CampeaoColors.primaryColor
                  : CampeaoColors.primaryTextColor);
  }

  InputBorder _createBorder() {
    return widget.isUnderlined
              ? const UnderlineInputBorder()
              : const OutlineInputBorder();
  }

  InputBorder _createFocusedBorder() {
    return widget.isUnderlined
              ? _createUnderlinedFocusedBorder()
              : _createRoundedFocusedBorder();
  }

  OutlineInputBorder _createRoundedFocusedBorder() {
    return const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide:
                    BorderSide(color: CampeaoColors.primaryColorDark),
              );
  }

  UnderlineInputBorder _createUnderlinedFocusedBorder() {
    return const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: CampeaoColors.primaryColorDark),
              );
  }

  InputBorder _createEnabledBorder() {
    return widget.isUnderlined
              ? _createUnderlinedEnabledBorder()
              : _createRoundedEnabledBorder();
  }

  OutlineInputBorder _createRoundedEnabledBorder() {
    return const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CampeaoColors.primaryColor),
              );
  }

  UnderlineInputBorder _createUnderlinedEnabledBorder() {
    return const UnderlineInputBorder(
                borderSide: BorderSide(color: CampeaoColors.primaryColor),
              );
  }

  Widget _createSuffixIconHidePassword() {
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

  void _setupFocusListener() {
    _textFieldFocusNode.addListener(() {
      setState(() {
        _backgroundColor = _textFieldFocusNode.hasFocus
            ? CampeaoColors.primaryColorSoft
            : widget.backgroundColor;
      });
    });
  }

  void _setupObscureText() {
    _obscureText = widget.hidePasswordEnabled;
  }
}

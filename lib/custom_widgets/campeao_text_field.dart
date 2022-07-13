import 'package:flutter/material.dart';

import '../color/theme_colors.dart';

class CampeaoInputTextField extends StatefulWidget {
  final Function onTextChanged;
  final String? initialText;
  final String? hintText;
  final String? errorText;
  final bool enabled;
  final bool hidePasswordEnabled;
  final bool errorActivated;
  final IconButton? suffixIconButton;
  final IconButton? prefixIconButton;

  const CampeaoInputTextField({
    Key? key,
    required this.onTextChanged,
    this.hintText,
    this.hidePasswordEnabled = false,
    this.initialText,
    this.enabled = true,
    this.errorText,
    this.errorActivated = false,
    this.prefixIconButton,
    this.suffixIconButton,
  }) : super(key: key);

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
    if (widget.initialText == null) {
      _fieldController.text = "";
    }
    return TextField(
      enabled: widget.enabled,
      controller: _fieldController,
      obscureText: _obscureText,
      focusNode: _textFieldFocusNode,
      style: const TextStyle(color: CampeaoColors.primaryTextColor),
      decoration: InputDecoration(
          errorText: widget.errorActivated ? widget.errorText : null,
          filled: true,
          fillColor: _backgroundColor,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CampeaoColors.primaryColorDark),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CampeaoColors.primaryColorDark),
          ),
          border: const OutlineInputBorder(),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: widget.enabled
                  ? CampeaoColors.primaryColorDark
                  : CampeaoColors.primaryTextColor),
          prefixIcon: widget.prefixIconButton,
          suffixIcon: widget.hidePasswordEnabled
              ? createSuffixIconHidePassword()
              : widget.suffixIconButton),
      onChanged: (newText) {
        widget.onTextChanged(newText);
      },
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

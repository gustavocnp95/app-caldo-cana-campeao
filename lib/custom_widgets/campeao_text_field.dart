import 'package:flutter/material.dart';

import '../color/theme_colors.dart';

class CampeaoInputTextField extends StatefulWidget {
  final Function onTextChanged;
  final String? hintText;
  final bool hidePasswordEnabled;

  const CampeaoInputTextField(
      {Key? key,
      required this.onTextChanged,
      this.hintText,
      this.hidePasswordEnabled = false})
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
    return TextField(
      controller: _fieldController,
      obscureText: _obscureText,
      focusNode: _textFieldFocusNode,
      style: const TextStyle(color: CampeaoColors.primaryTextColor),
      decoration: InputDecoration(
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
          hintStyle: const TextStyle(color: CampeaoColors.primaryColorDark),
          suffixIcon: widget.hidePasswordEnabled
              ? createSuffixIconHidePassword()
              : null),
      onChanged: (newText) {
        widget.onTextChanged(newText);
      },
    );
  }

  Widget createSuffixIconHidePassword() {
    return IconButton(
        icon: const Icon(Icons.remove_red_eye_outlined),
        color: CampeaoColors.primaryColorDark,
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

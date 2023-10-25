import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CostomTextFormField extends StatelessWidget {
  final String label;
  final String? initValue;
  final IconData? iconTextField;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool readOnly;
  final TextEditingController? inputController;
  final List<TextInputFormatter>? inputTextNumber;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final void Function(String text)? onChanged;
  final void Function()? onTap;

  const CostomTextFormField(
      {super.key,
      required this.label,
      this.initValue,
      this.iconTextField,
      required this.obscureText,
      this.keyboardType,
      this.validator,
      this.onSaved,
      this.onTap,
      this.onChanged,
      required this.readOnly,
      this.inputController,
      this.inputTextNumber});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: inputController,
      inputFormatters: inputTextNumber,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 0, 100, 0),
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          prefixIcon: iconTextField != null ? Icon(iconTextField) : null),
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
    );
  }
}

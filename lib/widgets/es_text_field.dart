import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EsTextField<T> extends StatelessWidget{
  final String formControlName;
  final String labelText;
  final Widget? suffixIcon;
  final void Function(FormControl<T> value)? onChanged;
  final void Function(FormControl<T> value)? onEditingComplete;
  final bool obscureText;
  final bool autofocus;
  final bool readOnly;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;

  const EsTextField({
    super.key,
    required this.formControlName,
    this.labelText = '',
    this.suffixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.obscureText = false,
    this.autofocus = false,
    this.readOnly = false,
    this.keyboardType,
    this.maxLines,
    this.minLines
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<T>(
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      formControlName: formControlName,
      obscureText: obscureText,
      readOnly: readOnly,
      showErrors: (control) => control.invalid && control.touched && control.dirty,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFF626262))
        ),
        suffixIcon: suffixIcon
      ),
    );
  }
}
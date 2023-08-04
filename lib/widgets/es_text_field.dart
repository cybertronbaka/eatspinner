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

  const EsTextField({
    super.key,
    required this.formControlName,
    this.labelText = '',
    this.suffixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.obscureText = false,
    this.autofocus = false,
    this.readOnly = false
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<T>(
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
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: suffixIcon
      ),
    );
  }
}
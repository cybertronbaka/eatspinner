import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EsDropdownField<T> extends StatelessWidget{
  final String formControlName;
  final String labelText;
  final List<DropdownMenuItem<T>> items;
  const EsDropdownField({
    super.key,
    required this.formControlName,
    required this.items,
    this.labelText = '',
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveDropdownField<T>(
      formControlName: formControlName,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: items
    );
  }
}
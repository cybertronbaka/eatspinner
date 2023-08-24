import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EsPasswordField extends StatefulWidget{
  final String formControlName;
  final String labelText;
  final void Function(FormControl control)? onEditingComplete;
  final bool autofocus;
  const EsPasswordField({
    Key? key,
    required this.formControlName,
    required this.labelText,
    this.onEditingComplete,
    this.autofocus = false
  }) : super(key: key);

  @override
  State<EsPasswordField> createState() => _EsPasswordFieldState();
}

class _EsPasswordFieldState extends State<EsPasswordField>{
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    return EsTextField(
      formControlName: widget.formControlName,
      labelText: widget.labelText,
      obscureText: hidden,
      onEditingComplete: widget.onEditingComplete,
      autofocus: widget.autofocus,
      maxLines: 1,
      suffixIcon: InkWell(
        child: Icon(
          hidden ? Icons.lock_open_outlined : Icons.lock_outlined,
        ),
        onTap: () {
          setState(() { hidden = !hidden; });
        },
      ),
    );
  }
}
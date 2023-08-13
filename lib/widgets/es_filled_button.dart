import 'package:flutter/material.dart';

class EsFilledButton extends StatelessWidget{
  final void Function()? onPressed;
  final String? labelText;

  const EsFilledButton({
    super.key,
    this.onPressed,
    this.labelText
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(labelText ?? ''),
          )
      ),
    );
  }
}
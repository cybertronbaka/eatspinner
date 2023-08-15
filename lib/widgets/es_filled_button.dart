import 'package:flutter/material.dart';

class EsFilledButton extends StatelessWidget{
  final void Function()? onPressed;
  final String? labelText;
  final double width;

  const EsFilledButton({
    super.key,
    this.onPressed,
    this.labelText,
    this.width = 1000
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
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
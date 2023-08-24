import 'package:flutter/material.dart';

class EsFilledButton extends StatelessWidget{
  final void Function()? onPressed;
  final String? labelText;
  final double width;
  final EdgeInsetsGeometry padding;

  const EsFilledButton({
    super.key,
    this.onPressed,
    this.labelText,
    this.width = 1000,
    this.padding = const EdgeInsets.all(20)
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
            padding: padding,
            child: Text(labelText ?? ''),
          )
      ),
    );
  }
}

class EsFilledIconButton extends StatelessWidget{
  final Widget icon;
  final void Function()? onPressed;
  final double width;

  const EsFilledIconButton({
    super.key,
    required this.icon,
    this.onPressed,
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
          child: icon
      ),
    );
  }
}
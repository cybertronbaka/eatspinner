import 'package:flutter/material.dart';

class EsCircularIconButton extends StatelessWidget{
  final Color backgroundColor;
  final Widget icon;
  final void Function() onTap;
  const EsCircularIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(200),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: icon,
          ),
        ),
      ),
    );
  }
}
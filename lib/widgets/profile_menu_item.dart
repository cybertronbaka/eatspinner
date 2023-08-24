import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget{
  final String title;
  final Icon icon;
  final void Function() onTap;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFF5F4F4)),
          color: const Color(0xFFFAF9F9),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Expanded(child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                )),
                icon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

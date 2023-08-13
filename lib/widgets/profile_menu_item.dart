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
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        color: const Color(0xFFFAF9F9),
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
    );
  }
}

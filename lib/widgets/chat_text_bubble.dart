import 'package:flutter/material.dart';

class ChatTextBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  const ChatTextBubble({
    super.key,
    required this.isSender,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    final fullWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        if(isSender) const Expanded(child: SizedBox(width: 5)),
        Container(
          constraints: BoxConstraints(
              minWidth: 10,
              maxWidth: fullWidth * 0.7
          ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
              color: isSender ? const Color(0xFFFBAED3) : const Color(0xFFEFEEEE),
              borderRadius: BorderRadius.only(
                topLeft: isSender ? const Radius.circular(24) : Radius.zero,
                topRight: isSender ? Radius.zero : const Radius.circular(24),
                bottomLeft: const Radius.circular(24),
                bottomRight: const Radius.circular(24),
              )
          ),
          child: Text(text),
        ),
      ],
    );
  }
}
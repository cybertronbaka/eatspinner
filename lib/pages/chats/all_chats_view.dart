import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';

class AllChatsView extends StatelessWidget {
  const AllChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(40, (index) => const EsChatCard()),
    );
  }
}
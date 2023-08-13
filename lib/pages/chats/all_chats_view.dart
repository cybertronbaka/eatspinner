import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';

class AllChatsView extends StatelessWidget {
  const AllChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: List.generate(40, (index) => const EsChatCard()),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: (){},
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
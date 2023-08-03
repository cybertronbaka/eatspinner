import 'package:flutter/material.dart';

class SpacedColumn extends StatelessWidget {
  final double spaceHeight;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  const SpacedColumn({
    Key? key,
    required this.children,
    this.spaceHeight = 0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
    this.textBaseline
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: generateChildren(),
    );
  }

  List<Widget> generateChildren(){
    List<Widget> kids = [];
    for(var i = 0; i < children.length; i++){
      kids.add(children[i]);
      if(i != children.length - 1) kids.add(SizedBox(height: spaceHeight));
    }
    return kids;
  }
}
import 'package:flutter/material.dart';

class SpacedRow extends StatelessWidget {
  final double spaceWidth;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  const SpacedRow({
    Key? key,
    required this.children,
    this.spaceWidth = 0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
    this.textBaseline
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpacedRow(
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
      if(i != children.length - 1) kids.add(SizedBox(width: spaceWidth));
    }
    return kids;
  }
}
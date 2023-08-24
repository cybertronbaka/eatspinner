import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EsTextFieldShimmer extends StatelessWidget {
  const EsTextFieldShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color(0xFFD2D2D2),
        highlightColor: const Color(0xFFE5E5E5),
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        )
    );
  }
}

class EsTextFieldMultiLineShimmer extends StatelessWidget {
  final int lines;
  const EsTextFieldMultiLineShimmer({
    super.key,
    this.lines = 1
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color(0xFFD2D2D2),
        highlightColor: const Color(0xFFE5E5E5),
        child: Container(
          height: lines == 1 ? 60 : (60 + ( 0.15 * 60 * lines)),
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        )
    );
  }
}
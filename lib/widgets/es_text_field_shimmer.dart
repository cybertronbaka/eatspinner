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
          height: 65,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        )
    );
  }
}
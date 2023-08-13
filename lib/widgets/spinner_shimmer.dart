import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SpinnerShimmer extends StatelessWidget {
  const SpinnerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(flex: 6, child: Shimmer.fromColors(
          baseColor: const Color(0xFFD2D2D2),
          highlightColor: const Color(0xFFE5E5E5),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
              ),
            ),
          ),
        )),
        const SizedBox(height: 20),
        Shimmer.fromColors(
          baseColor: const Color(0xFFD2D2D2),
          highlightColor: const Color(0xFFE5E5E5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(6))
              ),
            ),
          ),
        ),
        Expanded(flex: 2, child: Container())
      ],
    );
  }
}
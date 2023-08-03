import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:shimmer/shimmer.dart';

class PlaceCardShimmer extends StatelessWidget {
  const PlaceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Card(
        color: const Color(0xFFFCFCFC),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Expanded(flex: 3, child: Shimmer.fromColors(
              baseColor: const Color(0xFFD2D2D2),
              highlightColor: const Color(0xFFE5E5E5),
              child: Container(
                color: Colors.white,
              )
            )),
            Expanded(flex: 2, child: Row(
                children: [
                  Expanded(flex: 2, child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Shimmer.fromColors(
                          baseColor: const Color(0xFFD2D2D2),
                          highlightColor: const Color(0xFFE5E5E5),
                          child: const RatingStars(
                            value: 0.0,
                            starColor: Colors.orange
                          ),
                        ),
                        const SizedBox(height: 10),
                        Shimmer.fromColors(
                          baseColor: const Color(0xFFD2D2D2),
                          highlightColor: const Color(0xFFE5E5E5),
                          child: Container(
                            height: 20,
                            color: Colors.white,
                          )
                        ),
                        const SizedBox(height: 5),
                        Shimmer.fromColors(
                            baseColor: const Color(0xFFD2D2D2),
                            highlightColor: const Color(0xFFE5E5E5),
                            child: Container(
                              height: 20,
                              color: Colors.white,
                            )
                        ),
                      ],
                    ),
                  )),
                  Expanded(child:  Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Shimmer.fromColors(
                              baseColor: const Color(0xFFD2D2D2),
                              highlightColor: const Color(0xFFE5E5E5),
                              child: Container(
                                height: 25,
                                width: 25,
                                color: Colors.white,
                              )
                          ),
                          const SizedBox(width: 10),
                          Shimmer.fromColors(
                              baseColor: const Color(0xFFD2D2D2),
                              highlightColor: const Color(0xFFE5E5E5),
                              child: Container(
                                height: 25,
                                width: 25,
                                color: Colors.white,
                              )
                          ),
                          const SizedBox(width: 10),
                        ],
                      )
                    ],
                  ))
                ]
            ))
          ],
        ),
      ),
    );
  }
}
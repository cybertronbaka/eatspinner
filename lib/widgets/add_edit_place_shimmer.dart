import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:shimmer/shimmer.dart';

class AddEditPlaceFormShimmer extends StatelessWidget {
  const AddEditPlaceFormShimmer({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      child: SpacedColumn(
        spaceHeight: 20,
        children: [
          const EsTextFieldShimmer(),
          const EsTextFieldShimmer(),
          Shimmer.fromColors(
              baseColor: const Color(0xFFD2D2D2),
              highlightColor: const Color(0xFFE5E5E5),
              child: Container(
                height: 200,
                color: Colors.white,
              )
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Shimmer.fromColors(
                baseColor: const Color(0xFFD2D2D2),
                highlightColor: const Color(0xFFE5E5E5),
                child: const RatingStars(
                  value: 0,
                  starCount: 5,
                  starSize: 30,
                  valueLabelColor: Color(0xff9b9b9b),
                  valueLabelTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16
                  ),
                  valueLabelRadius: 10,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: true,
                  valueLabelVisibility: true,
                  animationDuration: Duration(seconds: 1),
                  valueLabelPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  starOffColor: Color(0xffe7e8ea),
                  starColor: Colors.orange,
                )
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Shimmer.fromColors(
                baseColor: const Color(0xFFD2D2D2),
                highlightColor: const Color(0xFFE5E5E5),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(1000)
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}
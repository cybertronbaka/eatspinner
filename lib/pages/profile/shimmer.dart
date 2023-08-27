import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePageShimmer extends StatelessWidget {
  final bool isMine;
  const ProfilePageShimmer({
    super.key,
    this.isMine = false
  });

  @override
  Widget build(BuildContext context) {
    const coverPhotoHeight = 150.0;

    return ListView(
      children: [
        SizedBox(
          height: coverPhotoHeight * 1.3,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Shimmer.fromColors(
                  baseColor: const Color(0xFFD2D2D2),
                  highlightColor: const Color(0xFFE5E5E5),
                  child: const CoverPhoto(
                    url: '',
                    height: coverPhotoHeight,
                  )
              ),
              Positioned(
                bottom: 0,
                left: 10,
                child: Shimmer.fromColors(
                  baseColor: const Color(0xFFD2D2D2),
                  highlightColor: const Color(0xFFE5E5E5),
                  child: const ProfilePhoto(
                    url: '',
                    hasBorder: true,
                    diameter: coverPhotoHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                  baseColor: const Color(0xFFD2D2D2),
                  highlightColor: const Color(0xFFE5E5E5),
                  child: Container(
                    height: 20,
                    width: 120,
                    color: Colors.white,
                  )
              ),
              const SizedBox(height: 8),
              Shimmer.fromColors(
                  baseColor: const Color(0xFFD2D2D2),
                  highlightColor: const Color(0xFFE5E5E5),
                  child: Container(
                    height: 20,
                    width: 100,
                    color: Colors.white,
                  )
              ),
              const SizedBox(height: 20),
              // TODO: Do Not show if profile is of current user's
              if(!isMine) Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Shimmer.fromColors(
                        baseColor: const Color(0xFFD2D2D2),
                        highlightColor: const Color(0xFFE5E5E5),
                        child: SizedBox(
                          height: 50,
                          child: EsFilledButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: (){},
                            labelText: 'Add to Contacts',
                          ),
                        )
                    ),
                  ),
                  const SizedBox(width: 10),
                  Shimmer.fromColors(
                    baseColor: const Color(0xFFD2D2D2),
                    highlightColor: const Color(0xFFE5E5E5),
                    child: SizedBox(
                      height: 50,
                      width: 60,
                      child:  EsFilledIconButton(
                          onPressed: (){

                          },
                          icon: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            child: Icon(Icons.message_outlined),
                          )
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Shimmer.fromColors(
                      baseColor: const Color(0xFFD2D2D2),
                      highlightColor: const Color(0xFFE5E5E5),
                      child: SizedBox(
                        height: 50,
                        width: 60,
                        child:  EsFilledIconButton(
                            onPressed: (){

                            },
                            icon: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 0),
                              child: Icon(Icons.more_horiz_outlined),
                            )
                        ),
                      )
                  ),
                ],
              ),
              if(!isMine) const SizedBox(height: 30),
              SpacedColumn(
                spaceHeight: 15,
                children: List.generate(4, (i) => Row(
                  children: [
                    Shimmer.fromColors(
                        baseColor: const Color(0xFFD2D2D2),
                        highlightColor: const Color(0xFFE5E5E5),
                        child: Container(
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        )
                    ),
                    const SizedBox(width: 10),
                    Shimmer.fromColors(
                        baseColor: const Color(0xFFD2D2D2),
                        highlightColor: const Color(0xFFE5E5E5),
                        child: Container(
                          height: 20,
                          width: 50,
                          color: Colors.white,
                        )
                    ),
                    const Spacer(),
                    Shimmer.fromColors(
                        baseColor: const Color(0xFFD2D2D2),
                        highlightColor: const Color(0xFFE5E5E5),
                        child: Container(
                          height: 20,
                          width: 50,
                          color: Colors.white,
                        )
                    ),
                  ],
                )),
              )
            ],
          ),
        )
      ],
    );
  }
}
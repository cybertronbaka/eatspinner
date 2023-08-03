import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:latlong2/latlong.dart';

class PlaceCard extends StatelessWidget{
  final Place place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Card(
        color: const Color(0xFFFCFCFC),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Expanded(flex: 3, child: MapViewWidget(
              location: LatLng(place.lat ?? 0.0, place.lon ?? 0.0),
              zoom: 17,
            )),
            Expanded(flex: 2, child: Row(
                children: [
                  Expanded(flex: 2, child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        RatingStars(value: place.rating ?? 0.0, starColor: Colors.orange),
                        const SizedBox(height: 10),
                        Text('Name: ${place.name ?? '--'}'),
                        const SizedBox(height: 5),
                        Text('Name: ${place.description ?? '--'}'),
                      ],
                    ),
                  )),
                  Expanded(child:  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.edit_outlined, size: 20)
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.delete_outlined, color: Colors.red, size: 20)
                          )
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
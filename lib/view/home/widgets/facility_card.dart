import 'dart:ui';

import 'package:adda/view/booking_view/booking_view.dart';
import 'package:flutter/material.dart';

import '../../../model/facility_model.dart';

class FacilityCard extends StatelessWidget {
  const FacilityCard(
      {super.key, required this.facilities, required this.index});

  final List<FacilityModel> facilities;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    BookingView(facilities: facilities, index: index)));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Align(
          child: Hero(
            tag: facilities[index].image,
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                height: 130,
                width: 130,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: ExactAssetImage(facilities[index].image),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Align(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 150, minWidth: 150),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.grey.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Text(
                            facilities[index].facilityName,
                            style: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

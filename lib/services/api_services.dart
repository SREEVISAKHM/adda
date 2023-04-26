import 'package:adda/model/facility_model.dart';

class ApiService {
  List<Map<String, dynamic>> facilityResponse = [
    {
      "facilityName": "  Club\nHouse",
      "image": "assets/images/clubhouse.jpg",
      "hourlyPrice": 100
    },
    {
      "facilityName": "Tennis\n Court",
      "image": "assets/images/tennise.jpg",
      "hourlyPrice": 50
    },
    {
      "facilityName": "Gym",
      "image": "assets/images/gym.jpg",
      "hourlyPrice": 500
    },
  ];

  List<FacilityModel> fetchFacility() {
    List<FacilityModel> facilities = [];
    for (var facility in facilityResponse) {
      facilities.add(FacilityModel.fromMap(facility));
    }
    return facilities;
  }
}

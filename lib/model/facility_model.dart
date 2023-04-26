class FacilityModel {
  String facilityName;
  String image;
  int hourlyPrice;

  FacilityModel({
    required this.facilityName,
    required this.image,
    required this.hourlyPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'facilityName': facilityName,
      'image': image,
    };
  }

  factory FacilityModel.fromMap(Map<String, dynamic> map) {
    return FacilityModel(
        facilityName: map['facilityName'] ?? '',
        image: map['image'] ?? '',
        hourlyPrice: map['hourlyPrice'] ?? 0);
  }
}

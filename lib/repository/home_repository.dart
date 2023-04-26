import 'package:adda/model/facility_model.dart';
import 'package:adda/services/api_services.dart';

class HomeRepository {
  ApiService apiService;
  HomeRepository({
    required this.apiService,
  });

  List<FacilityModel> getfacilities() {
    return apiService.fetchFacility();
  }
}

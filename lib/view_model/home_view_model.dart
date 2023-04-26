import 'package:adda/model/facility_model.dart';
import 'package:adda/repository/home_repository.dart';

class HomeViewModel {
  HomeRepository homeRepository;

  HomeViewModel({
    required this.homeRepository,
  });

  List<FacilityModel> _facilities = [];
  List<FacilityModel> get facilities => _facilities;
  set facilities(value) => _facilities = value;

  void getFacility() {
    _facilities.addAll(homeRepository.getfacilities());
  }
}

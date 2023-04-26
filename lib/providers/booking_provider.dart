import 'package:adda/view_model/booking_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingProvider = ChangeNotifierProvider((ref) => BookingViewModel());

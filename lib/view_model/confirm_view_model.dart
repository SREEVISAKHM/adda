import 'dart:developer';

import 'package:adda/model/selected_slots.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmViewModel extends ChangeNotifier {
  double _total = 0;
  double get total => _total;

  set total(double value) {
    _total = value;
    notifyListeners();
  }

  double toDouble(Duration myTime) => double.parse(myTime.inMinutes.toString());
  void getTotal(String startTime, String endTime, int hourlyPrice) {
    var format = DateFormat("hh:mm");
    DateTime one = format.parse(startTime);
    DateTime two = format.parse(endTime);
    var myTime = two.difference(one);

    log(two.difference(one).toString());
    var tempValue = toDouble(myTime);
    log(tempValue.toString());

    var totalValue = ((hourlyPrice) / 60) * tempValue;
    total = totalValue.ceilToDouble();
  }

  List<SelectedSlots> _selectedSlots = [];
  List<SelectedSlots> get selectedSlots => _selectedSlots;

  set selectedSlots(List<SelectedSlots> value) {
    _selectedSlots = value;
    notifyListeners();
  }

  void addToSlots(SelectedSlots selectedSlotsVariable) {
    selectedSlots.add(selectedSlotsVariable);
  }
}

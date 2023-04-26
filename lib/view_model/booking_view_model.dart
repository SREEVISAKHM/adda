import 'package:flutter/material.dart';

class BookingViewModel extends ChangeNotifier {
  String _dateValue = 'Choose Date';
  String get dateValue => _dateValue;

  set dateValue(String value) {
    _dateValue = value;
    notifyListeners();
  }

  void getDate(DateTime? date) {
    if (date == null) {
      dateValue = 'Choose Date';
    } else {
      dateValue = '${date.day} - ${date.month} - ${date.year}';
    }
  }

  String _startTimeValue = 'Choose Time';
  String get startTimeValue => _startTimeValue;

  set startTimeValue(String value) {
    _startTimeValue = value;
    notifyListeners();
  }

  String _endTimeValue = '';
  String get endTimeValue => _endTimeValue;

  set endTimeValue(String value) {
    _endTimeValue = value;
    notifyListeners();
  }

  void getTime(TimeOfDay? startTime, TimeOfDay? endTime, BuildContext context) {
    if (startTime == null || endTime == null) {
      startTimeValue = 'Choose Time';
      endTimeValue = '';
    } else {
      startTimeValue = startTime.format(context);
      endTimeValue = endTime.format(context);
    }
  }
}

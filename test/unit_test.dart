import 'package:adda/model/selected_slots.dart';
import 'package:adda/view_model/confirm_view_model.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConfirmViewModel tests', () {
    ConfirmViewModel? confirmViewModel;

    setUp(() {
      confirmViewModel = ConfirmViewModel();
    });

    test('ConfirmViewModel getTotal', () {
      confirmViewModel!.getTotal('10:00', '11:30', 100);
      expect(confirmViewModel!.total, equals(150));
    });

    test('ConfirmViewModel addToSlots', () {
      final selectedSlot = SelectedSlots(
          date: '2022-01-01',
          startTime: '10:00',
          endTime: '11:00',
          facility: 'club house');
      confirmViewModel!.addToSlots(selectedSlot);
      expect(confirmViewModel?.selectedSlots.length, equals(1));
      expect(confirmViewModel?.selectedSlots.first.date, equals('2022-01-01'));
      expect(confirmViewModel?.selectedSlots.first.startTime, equals('10:00'));
      expect(confirmViewModel?.selectedSlots.first.endTime, equals('11:00'));
      expect(
          confirmViewModel?.selectedSlots.first.facility, equals('club house'));
    });
  });
}

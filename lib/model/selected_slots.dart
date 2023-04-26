class SelectedSlots {
  String date;
  String startTime;
  String facility;
  SelectedSlots({
    required this.date,
    required this.startTime,
    required this.facility,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'startTime': startTime,
    };
  }

  factory SelectedSlots.fromMap(Map<String, dynamic> map) {
    return SelectedSlots(
        date: map['date'] ?? '',
        startTime: map['startTime'] ?? '',
        facility: map['facility'] ?? '');
  }

  @override
  String toString() {
    return '{$date , $startTime $facility}';
  }
}

class SelectedSlots {
  String date;
  String startTime;
  String facility;
  String endTime;

  SelectedSlots({
    required this.date,
    required this.startTime,
    required this.facility,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'startTime': startTime,
      'facility': facility,
      'endTime': endTime,
    };
  }

  factory SelectedSlots.fromMap(Map<String, dynamic> map) {
    return SelectedSlots(
      date: map['date'] ?? '',
      startTime: map['startTime'] ?? '',
      facility: map['facility'] ?? '',
      endTime: map['endTime'] ?? '',
    );
  }

  @override
  bool operator ==(other) {
    return other is SelectedSlots &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.facility == facility;
  }

  @override
  int get hashCode => Object.hash(date, startTime, facility, endTime);

  @override
  String toString() {
    return '{$date , $startTime ,$facility}';
  }
}

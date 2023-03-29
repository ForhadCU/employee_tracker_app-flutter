class Item {
  final String startTime;
  final String endTime;
  final String duration;

  Item(
      {required this.startTime, required this.endTime, required this.duration});
}

class RecordsModel {
  static final items = [
    Item(startTime: "2.45 PM", endTime: "null", duration: "02.13.25"),
    Item(startTime: "2.45 PM", endTime: "4.45 PM", duration: "02.13.25"),
    Item(startTime: "2.45 PM", endTime: "4.45 PM", duration: "02.13.25"),
    Item(startTime: "2.45 PM", endTime: "4.45 PM", duration: "02.13.25"),
    Item(startTime: "2.45 PM", endTime: "4.45 PM", duration: "02.13.25"),
  ];
}

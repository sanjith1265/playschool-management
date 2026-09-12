class Dashboard {
  final int totalChildren;
  final int presentToday;
  final int absentToday;
  final int activities;

  Dashboard({
    required this.totalChildren,
    required this.presentToday,
    required this.absentToday,
    required this.activities,
  });

  factory Dashboard.fromJson(
      Map<String, dynamic> json) {
    return Dashboard(
      totalChildren:
          json["totalChildren"],
      presentToday:
          json["presentToday"],
      absentToday:
          json["absentToday"],
      activities:
          json["activities"],
    );
  }
}
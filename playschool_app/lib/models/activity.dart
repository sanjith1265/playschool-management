class Activity {
  final String id;
  final String title;
  final String description;
  final String date;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory Activity.fromJson(
      Map<String, dynamic> json) {
    return Activity(
      id: json['_id'],
      title: json['title'],
      description:
          json['description'],
      date: json['date'],
    );
  }
}
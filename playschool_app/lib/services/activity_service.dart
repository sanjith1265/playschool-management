import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/activity.dart';

class ActivityService {

  static const String baseUrl =
      "http://localhost:5000";

  Future<List<Activity>>
      getActivities() async {

    final response =
        await http.get(
      Uri.parse(
        "$baseUrl/api/activities",
      ),
    );

    final data =
        jsonDecode(response.body);

    return data
        .map<Activity>(
          (item) =>
              Activity.fromJson(item),
        )
        .toList();
  }

  Future<void> createActivity({
    required String title,
    required String description,
    required String date,
  }) async {

    await http.post(
      Uri.parse(
        "$baseUrl/api/activities",
      ),

      headers: {
        "Content-Type":
            "application/json",
      },

      body: jsonEncode({
        "title": title,
        "description":
            description,
        "date": date,
      }),
    );
  }
}
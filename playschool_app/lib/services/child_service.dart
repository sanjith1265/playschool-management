import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/child.dart';

class ChildService {
  static const String baseUrl = "http://localhost:5000";

  Future<List<Child>> getChildren() async {
    final response = await http.get(Uri.parse("$baseUrl/api/children"));

    final data = jsonDecode(response.body);

    return data.map<Child>((e) => Child.fromJson(e)).toList();
  }

  Future<void> addChild({
    required String name,
    required String dateOfBirth,
    required String gender,
    required int monthlyFee,
  }) async {
    await http.post(
      Uri.parse("$baseUrl/api/children"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({
        "name": name,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "monthlyFee": monthlyFee,
      }),
    );
  }

  Future<void> deleteChild(String id) async {
    await http.delete(Uri.parse("$baseUrl/api/children/$id"));
  }

  Future<void> updateChild({
  required String id,
  required String name,
  required String dateOfBirth,
  required String gender,
  required int monthlyFee,
}) async {
  await http.put(
    Uri.parse("$baseUrl/api/children/$id"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "name": name,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "monthlyFee": monthlyFee,
    }),
  );
}
}

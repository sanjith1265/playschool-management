import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/parent.dart';

class ParentService {
  static const String baseUrl = "http://localhost:5000";

  Future<List<Parent>> getParents() async {
    final response = await http.get(Uri.parse("$baseUrl/api/parents"));

    final List data = jsonDecode(response.body);

    return data.map((e) => Parent.fromJson(e)).toList();
  }

  Future<void> addParent({
  required String childId,
  required String fatherName,
  required String motherName,
  required String phone,
  required String email,
  required String address,
}) async {
  final response = await http.post(
    Uri.parse("$baseUrl/api/parents"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "childId": childId,
      "fatherName": fatherName,
      "motherName": motherName,
      "phone": phone,
      "email": email,
      "address": address,
    }),
  );

  if (response.statusCode != 201) {
    throw Exception(jsonDecode(response.body)["message"]);
  }
}
Future<void> updateParent({
  required String id,
  required String fatherName,
  required String motherName,
  required String phone,
  required String email,
  required String address,
}) async {
  final response = await http.put(
    Uri.parse("$baseUrl/api/parents/$id"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "fatherName": fatherName,
      "motherName": motherName,
      "phone": phone,
      "email": email,
      "address": address,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception("Failed to update parent");
  }
}

Future<void> deleteParent(String id) async {
  final response = await http.delete(
    Uri.parse("$baseUrl/api/parents/$id"),
  );

  if (response.statusCode != 200) {
    throw Exception("Failed to delete parent");
  }
}
}

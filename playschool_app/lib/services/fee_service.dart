import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/fee.dart';

class FeeService {

  static const String baseUrl =
      "http://localhost:5000";

  Future<List<Fee>> getFees()
      async {

    final response =
        await http.get(
      Uri.parse(
        "$baseUrl/api/fees",
      ),
    );

    final data =
        jsonDecode(response.body);

    return data
        .map<Fee>(
          (item) =>
              Fee.fromJson(item),
        )
        .toList();
  }
  Future<void> markPaid({
  required String id,
  required int amount,
  required String method,
}) async {

  final today =
      DateTime.now()
          .toIso8601String()
          .split("T")[0];

  await http.put(
    Uri.parse(
      "$baseUrl/api/fees/$id/pay",
    ),

    headers: {
      "Content-Type":
          "application/json",
    },

    body: jsonEncode({
      "paidAmount": amount,
      "paymentDate": today,
      "paymentMethod": method,
    }),
  );
}
}
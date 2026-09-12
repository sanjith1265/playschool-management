import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dashboard.dart';

class DashboardService {
  static const baseUrl =
      "http://localhost:5000";

  Future<Dashboard>
      getDashboard() async {

    final response =
        await http.get(
      Uri.parse(
        "$baseUrl/api/dashboard",
      ),
    );

    return Dashboard.fromJson(
      jsonDecode(response.body),
    );
  }
}
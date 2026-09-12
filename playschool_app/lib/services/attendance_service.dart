import 'dart:convert';
import 'package:http/http.dart' as http;

class AttendanceService {
  static const String baseUrl = "http://localhost:5000";

  Future<void> markAttendance({
    required String childId,
    required String date,
    required String status,
  }) async {
    await http.post(
      Uri.parse("$baseUrl/api/attendance"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"childId": childId, "date": date, "status": status}),
    );
  }

  Future<List<dynamic>> getAttendanceByDate(String date) async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/attendance/date/$date"),
    );

    return jsonDecode(response.body);
  }
}

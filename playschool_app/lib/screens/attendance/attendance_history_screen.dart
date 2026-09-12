import 'package:flutter/material.dart';
import '../../services/attendance_service.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  final dateController = TextEditingController();

  List<dynamic> records = [];

  Future<void> loadData() async {
    records = await AttendanceService().getAttendanceByDate(
      dateController.text,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance History")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Select Date",
                suffixIcon: Icon(Icons.calendar_today),
              ),

              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2035),
                );

                if (pickedDate != null) {
                  dateController.text = pickedDate.toIso8601String().split(
                    "T",
                  )[0];

                  setState(() {});
                }
              },
            ),

            const SizedBox(height: 10),

            ElevatedButton(onPressed: loadData, child: const Text("Search")),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: records.length,

                itemBuilder: (context, index) {
                  final record = records[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),

                    child: ListTile(
                      leading: Icon(
                        record["status"] == "Present"
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: record["status"] == "Present"
                            ? Colors.green
                            : Colors.red,
                      ),

                      title: Text(record["childId"]["name"]),

                      subtitle: Text(record["status"]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

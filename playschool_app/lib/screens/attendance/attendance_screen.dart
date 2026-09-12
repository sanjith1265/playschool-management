import 'package:flutter/material.dart';
import '../../models/child.dart';
import '../../services/child_service.dart';
import '../../services/attendance_service.dart';
import 'attendance_history_screen.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late Future<List<Child>> childrenFuture;

  final attendanceMap = <String, bool>{};

  @override
  void initState() {
    super.initState();

    childrenFuture = ChildService().getChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance"),
      actions: [
        IconButton(
          icon: const Icon(Icons.history),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AttendanceHistoryScreen(),
              ),
            );
          },
        ),
      ],
      ),
      
      body: FutureBuilder<List<Child>>(
        future: childrenFuture,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final children = snapshot.data!;

          return ListView.builder(
            itemCount: children.length,

            itemBuilder: (context, index) {
              final child = children[index];

              return CheckboxListTile(
                title: Text(child.name),

                value: attendanceMap[child.id] ?? true,

                onChanged: (value) {
                  setState(() {
                    attendanceMap[child.id] = value!;
                  });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final children = await childrenFuture;

          final now = DateTime.now();

          final today =
            "${now.year}-"
            "${now.month.toString().padLeft(2, '0')}-"
            "${now.day.toString().padLeft(2, '0')}";

          for (final child in children) {
            await AttendanceService().markAttendance(
              childId: child.id,
              date: today,
              status: (attendanceMap[child.id] ?? true) ? "Present" : "Absent",
            );
          }

          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Attendance Saved")));
          }
        },
        label: const Text("Save"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}

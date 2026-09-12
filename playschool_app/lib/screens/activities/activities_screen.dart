import 'package:flutter/material.dart';
import '../../models/activity.dart';
import '../../services/activity_service.dart';
import 'add_activity_screen.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  late Future<List<Activity>> activitiesFuture;

  @override
  void initState() {
    super.initState();

    activitiesFuture = ActivityService().getActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activities"),

        actions: [
          IconButton(
            icon: const Icon(Icons.add),

            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddActivityScreen()),
              );

              if (result == true) {
                setState(() {
                  activitiesFuture = ActivityService().getActivities();
                });
              }
            },
          ),
        ],
      ),

      body: FutureBuilder<List<Activity>>(
        future: activitiesFuture,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final activities = snapshot.data!;

          return ListView.builder(
            itemCount: activities.length,

            itemBuilder: (context, index) {
              final activity = activities[index];

              return Card(
                margin: const EdgeInsets.all(8),

                child: ListTile(
                  title: Text(activity.title),

                  subtitle: Text("${activity.description}\n${activity.date}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

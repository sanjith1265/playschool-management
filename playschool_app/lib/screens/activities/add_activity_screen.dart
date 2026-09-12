import 'package:flutter/material.dart';
import '../../services/activity_service.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() =>
      _AddActivityScreenState();
}

class _AddActivityScreenState
    extends State<AddActivityScreen> {

  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final dateController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Activity",
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller:
                  titleController,
              decoration:
                  const InputDecoration(
                labelText:
                    "Title",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller:
                  descriptionController,
              maxLines: 3,
              decoration:
                  const InputDecoration(
                labelText:
                    "Description",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller:
                  dateController,
              readOnly: true,
              decoration:
                  const InputDecoration(
                labelText:
                    "Date",
                suffixIcon: Icon(
                  Icons.calendar_today,
                ),
              ),

              onTap: () async {

                final pickedDate =
                    await showDatePicker(
                  context: context,
                  initialDate:
                      DateTime.now(),
                  firstDate:
                      DateTime(2020),
                  lastDate:
                      DateTime(2035),
                );

                if (pickedDate !=
                    null) {

                  dateController.text =
                      pickedDate
                          .toIso8601String()
                          .split("T")[0];

                  setState(() {});
                }
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {

                await ActivityService()
                    .createActivity(
                  title:
                      titleController.text,
                  description:
                      descriptionController
                          .text,
                  date:
                      dateController.text,
                );

                if (mounted) {

                  Navigator.pop(
                    context,
                    true,
                  );
                }
              },

              child: const Text(
                "Save Activity",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
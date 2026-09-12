import 'package:flutter/material.dart';
import '../../models/child.dart';
import '../../services/child_service.dart';

class EditChildScreen extends StatefulWidget {
  final Child child;

  const EditChildScreen({
    super.key,
    required this.child,
  });

  @override
  State<EditChildScreen> createState() => _EditChildScreenState();
}

class _EditChildScreenState extends State<EditChildScreen> {
  late TextEditingController nameController;
  late TextEditingController feeController;
  late TextEditingController dobController;

  String gender = "Male";

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.child.name,
    );

    feeController = TextEditingController(
      text: widget.child.monthlyFee.toString(),
    );

    dobController = TextEditingController(
      text: widget.child.dateOfBirth.split("T")[0],
    );

    gender = widget.child.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Child"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Child Name",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: dobController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Date of Birth",
                suffixIcon: Icon(Icons.calendar_month),
              ),
              onTap: () async {
                DateTime initialDate;

                try {
                  initialDate = DateTime.parse(
                    dobController.text,
                  );
                } catch (_) {
                  initialDate = DateTime.now();
                }

                DateTime? pickedDate =
                    await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: DateTime(2015),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  dobController.text =
                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                }
              },
            ),

            const SizedBox(height: 12),

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Gender",
                  style: TextStyle(fontSize: 16),
                ),

                RadioListTile(
                  title: const Text("Male"),
                  value: "Male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),

                RadioListTile(
                  title: const Text("Female"),
                  value: "Female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextField(
              controller: feeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Monthly Fee",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await ChildService().updateChild(
                  id: widget.child.id,
                  name: nameController.text,
                  dateOfBirth: dobController.text,
                  gender: gender,
                  monthlyFee: int.parse(
                    feeController.text,
                  ),
                );

                if (mounted) {
                  Navigator.pop(
                    context,
                    true,
                  );
                }
              },
              child: const Text(
                "Update Child",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '/services/child_service.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final nameController = TextEditingController();

  final dobController = TextEditingController();

  final genderController = TextEditingController();

  final feeController = TextEditingController();

  String gender = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Child")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Child Name"),
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
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2015),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  dobController.text = pickedDate.toIso8601String().split(
                    "T",
                  )[0];
                }
              },
            ),

            const SizedBox(height: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Gender", style: TextStyle(fontSize: 16)),

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
              decoration: const InputDecoration(labelText: "Monthly Fee"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await ChildService().addChild(
                  name: nameController.text,
                  dateOfBirth: dobController.text,
                  gender: gender,
                  monthlyFee: int.parse(feeController.text),
                );

                if (mounted) {
                  Navigator.pop(context);
                }
              },

              child: const Text("Save Child"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../models/parent.dart';
import '../../services/parent_service.dart';

class EditParentScreen extends StatefulWidget {
  final Parent parent;

  const EditParentScreen({
    super.key,
    required this.parent,
  });

  @override
  State<EditParentScreen> createState() =>
      _EditParentScreenState();
}

class _EditParentScreenState
    extends State<EditParentScreen> {
  late TextEditingController fatherController;
  late TextEditingController motherController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();

    fatherController = TextEditingController(
      text: widget.parent.fatherName,
    );

    motherController = TextEditingController(
      text: widget.parent.motherName,
    );

    phoneController = TextEditingController(
      text: widget.parent.phone,
    );

    emailController = TextEditingController(
      text: widget.parent.email,
    );

    addressController = TextEditingController(
      text: widget.parent.address,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Parent"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: fatherController,
              decoration: const InputDecoration(
                labelText: "Father Name",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: motherController,
              decoration: const InputDecoration(
                labelText: "Mother Name",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: emailController,
              keyboardType:
                  TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Address",
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await ParentService()
                        .updateParent(
                      id: widget.parent.id,
                      fatherName:
                          fatherController.text,
                      motherName:
                          motherController.text,
                      phone:
                          phoneController.text,
                      email:
                          emailController.text,
                      address:
                          addressController.text,
                    );

                    if (mounted) {
                      Navigator.pop(
                        context,
                        true,
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content:
                            Text(e.toString()),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Update Parent",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
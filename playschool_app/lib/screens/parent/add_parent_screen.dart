import 'package:flutter/material.dart';
import '../../models/child.dart';
import '../../services/child_service.dart';
import '../../services/parent_service.dart';

class AddParentScreen extends StatefulWidget {
  const AddParentScreen({super.key});

  @override
  State<AddParentScreen> createState() => _AddParentScreenState();
}

class _AddParentScreenState extends State<AddParentScreen> {
  final fatherController = TextEditingController();
  final motherController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  late Future<List<Child>> childrenFuture;

  String? selectedChildId;

  @override
  void initState() {
    super.initState();
    childrenFuture = ChildService().getChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Parent")),
      body: FutureBuilder<List<Child>>(
        future: childrenFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final children = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Select Child",
                    border: OutlineInputBorder(),
                  ),
                  value: selectedChildId,
                  items: children.map((child) {
                    return DropdownMenuItem(
                      value: child.id,
                      child: Text(child.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedChildId = value;
                    });
                  },
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: fatherController,
                  decoration: const InputDecoration(
                    labelText: "Father Name",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: motherController,
                  decoration: const InputDecoration(
                    labelText: "Mother Name",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: addressController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedChildId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a child"),
                          ),
                        );
                        return;
                      }

                      try {
                        await ParentService().addParent(
                          childId: selectedChildId!,
                          fatherName: fatherController.text,
                          motherName: motherController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          address: addressController.text,
                        );

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Parent added successfully"),
                            ),
                          );

                          Navigator.pop(context, true);
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                e.toString().replaceFirst("Exception: ", ""),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

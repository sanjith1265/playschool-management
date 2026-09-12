import 'package:flutter/material.dart';
import '../../models/child.dart';
import '../../services/child_service.dart';
import 'add_children_screen.dart';
import 'child_details_screen.dart';

class ChildrenScreen extends StatefulWidget {
  const ChildrenScreen({super.key});

  @override
  State<ChildrenScreen> createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
  late Future<List<Child>> childrenFuture;

  @override
  void initState() {
    super.initState();
    childrenFuture = ChildService().getChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Children"),
      ),
      body: FutureBuilder<List<Child>>(
        future: childrenFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final children = snapshot.data!;

          return ListView.builder(
            itemCount: children.length,
            itemBuilder: (context, index) {
              final child = children[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  title: Text(
                    child.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),

                      Text("Gender : ${child.gender}"),

                      Text("Father : ${child.fatherName}"),

                      Text("Mother : ${child.motherName}"),

                      Text("Phone : ${child.parentPhone}"),

                      Text(
                        "Monthly Fee : ₹${child.monthlyFee}",
                      ),
                    ],
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ChildDetailsScreen(child: child),
                      ),
                    );
                  },

                  onLongPress: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Delete Child"),
                          content: Text(
                            "Delete ${child.name}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                  false,
                                );
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                  true,
                                );
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true) {
                      await ChildService().deleteChild(
                        child.id,
                      );

                      setState(() {
                        childrenFuture =
                            ChildService().getChildren();
                      });
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddChildScreen(),
            ),
          );

          setState(() {
            childrenFuture = ChildService().getChildren();
          });
        },
      ),
    );
  }
}
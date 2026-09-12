import 'package:flutter/material.dart';
import 'edit_parent_screen.dart';
import '../../models/parent.dart';
import '../../services/parent_service.dart';
import 'add_parent_screen.dart';

class ParentsScreen extends StatefulWidget {
  const ParentsScreen({super.key});

  @override
  State<ParentsScreen> createState() => _ParentsScreenState();
}

class _ParentsScreenState extends State<ParentsScreen> {
  late Future<List<Parent>> parentsFuture;

  @override
  void initState() {
    super.initState();
    parentsFuture = ParentService().getParents();
  }

  void refreshParents() {
    setState(() {
      parentsFuture = ParentService().getParents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Parents")),

      body: FutureBuilder<List<Parent>>(
        future: parentsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final parents = snapshot.data!;

          if (parents.isEmpty) {
            return const Center(child: Text("No parents added"));
          }

          return ListView.builder(
            itemCount: parents.length,

            itemBuilder: (context, index) {
              final parent = parents[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                child: ListTile(
                  title: Text(
                    parent.childName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Father: ${parent.fatherName}"),
                      Text("Mother: ${parent.motherName}"),
                      Text("Phone: ${parent.phone}"),
                    ],
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditParentScreen(parent: parent),
                            ),
                          );

                          if (result == true) {
                            refreshParents();
                          }
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Delete Parent"),
                              content: Text(
                                "Delete parent details for ${parent.childName}?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text("Cancel"),
                                ),

                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            await ParentService().deleteParent(parent.id);

                            refreshParents();

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Parent deleted successfully"),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddParentScreen()),
          );

          if (result == true) {
            refreshParents();
          }
        },
      ),
    );
  }
}

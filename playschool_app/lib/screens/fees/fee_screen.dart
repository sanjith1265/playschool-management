import 'package:flutter/material.dart';
import '../../models/fee.dart';
import '../../services/fee_service.dart';
import 'mark_paid_screen.dart';

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  late Future<List<Fee>> feesFuture;

  @override
  void initState() {
    super.initState();

    feesFuture = FeeService().getFees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fees")),

      body: FutureBuilder<List<Fee>>(
        future: feesFuture,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final fees = snapshot.data!;

          return ListView.builder(
            itemCount: fees.length,

            itemBuilder: (context, index) {
              final fee = fees[index];

              return Card(
                margin: const EdgeInsets.all(8),

                child: ListTile(
                  title: Text(fee.childName),

                  subtitle: Text(
                    "Month: ${fee.month}\nPaid: ₹${fee.paidAmount}",
                  ),

                  trailing: fee.status == "Pending"
                      ? ElevatedButton(
                          child: const Text("Mark Paid"),

                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MarkPaidScreen(
                                  feeId: fee.id,
                                  monthlyFee: fee.monthlyFee,
                                ),
                              ),
                            );

                            if (result == true) {
                              setState(() {
                                feesFuture = FeeService().getFees();
                              });
                            }
                          },
                        )
                      : const Chip(label: Text("Paid")),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../services/fee_service.dart';

class MarkPaidScreen extends StatefulWidget {

  final String feeId;
  final int monthlyFee;

  const MarkPaidScreen({
    super.key,
    required this.feeId,
    required this.monthlyFee,
  });

  @override
  State<MarkPaidScreen> createState() =>
      _MarkPaidScreenState();
}

class _MarkPaidScreenState
    extends State<MarkPaidScreen> {

  final amountController =
      TextEditingController();

  String paymentMethod =
      "Cash";

  @override
  void initState() {
    super.initState();

    amountController.text =
        widget.monthlyFee.toString();
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Mark Paid"),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller:
                  amountController,
              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(
                labelText:
                    "Paid Amount",
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            DropdownButton<String>(
              value: paymentMethod,

              isExpanded: true,

              items: const [
                DropdownMenuItem(
                  value: "Cash",
                  child: Text(
                    "Cash",
                  ),
                ),
                DropdownMenuItem(
                  value: "UPI",
                  child: Text(
                    "UPI",
                  ),
                ),
                DropdownMenuItem(
                  value: "Online",
                  child: Text(
                    "Online",
                  ),
                ),
                DropdownMenuItem(
                  value:
                      "Bank Transfer",
                  child: Text(
                    "Bank Transfer",
                  ),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  paymentMethod =
                      value!;
                });
              },
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () async {

                await FeeService()
                    .markPaid(
                  id: widget.feeId,
                  amount: int.parse(
                    amountController
                        .text,
                  ),
                  method:
                      paymentMethod,
                );

                if (mounted) {
                  Navigator.pop(
                    context,
                    true,
                  );
                }
              },

              child:
                  const Text(
                "Save",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
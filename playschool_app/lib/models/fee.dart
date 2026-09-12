class Fee {
  final String id;
  final String childName;
  final String month;
  final int monthlyFee;
  final int paidAmount;
  final String status;
  final String paymentDate;

  Fee({
    required this.id,
    required this.childName,
    required this.month,
    required this.monthlyFee,
    required this.paidAmount,
    required this.status,
    required this.paymentDate,
  });

  factory Fee.fromJson(
      Map<String, dynamic> json) {
    return Fee(
      id: json['_id'],
      childName:
          json['childId']['name'],
      month: json['month'],
      monthlyFee:
          json['monthlyFee'],
      paidAmount:
          json['paidAmount'],
      status: json['status'],
      paymentDate:
          json['paymentDate'] ?? '',
    );
  }
}
class Child {
  final String id;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String address;
  final int monthlyFee;

  final String fatherName;
  final String motherName;
  final String parentPhone;

  Child({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.monthlyFee,
    required this.fatherName,
    required this.motherName,
    required this.parentPhone,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    final List parents = json["parent"] ?? [];

    String fatherName = "Not Assigned";
    String motherName = "Not Assigned";
    String parentPhone = "Not Available";

    if (parents.isNotEmpty) {
      fatherName = parents[0]["fatherName"] ?? "Not Assigned";
      motherName = parents[0]["motherName"] ?? "Not Assigned";
      parentPhone = parents[0]["phone"] ?? "Not Available";
    }

    return Child(
      id: json["_id"],
      name: json["name"],
      dateOfBirth: json["dateOfBirth"] ?? "",
      gender: json["gender"] ?? "",
      address: parents.isNotEmpty ? parents[0]["address"] ?? "": "",      monthlyFee: json["monthlyFee"] ?? 0,
      fatherName: fatherName,
      motherName: motherName,
      parentPhone: parentPhone,
    );
  }
}
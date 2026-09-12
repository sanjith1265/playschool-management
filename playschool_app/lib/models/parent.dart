class Parent {
  final String id;
  final String childId;
  final String childName;
  final String fatherName;
  final String motherName;
  final String phone;
  final String email;
  final String address;

  Parent({
    required this.id,
    required this.childId,
    required this.childName,
    required this.fatherName,
    required this.motherName,
    required this.phone,
    required this.email,
    required this.address,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json["_id"],
      childId: json["childId"]["_id"],
      childName: json["childId"]["name"],
      fatherName: json["fatherName"],
      motherName: json["motherName"],
      phone: json["phone"],
      email: json["email"] ?? "",
      address: json["address"] ?? "",
    );
  }
}
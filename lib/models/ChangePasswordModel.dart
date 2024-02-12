class ChangePasswordModel {
  String status;
  String message;

  ChangePasswordModel({
    required this.status,
    required this.message,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

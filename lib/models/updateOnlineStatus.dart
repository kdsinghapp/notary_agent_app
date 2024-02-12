class UpdateOnlineStatus {
  String status;
  String data;
  String message;

  UpdateOnlineStatus({
    required this.status,
    required this.data,
    required this.message,
  });

  factory UpdateOnlineStatus.fromJson(Map<String, dynamic> json) => UpdateOnlineStatus(
    status: json["status"],
    data: json["data"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
    "message": message,
  };
}

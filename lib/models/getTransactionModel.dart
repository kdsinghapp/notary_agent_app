class GetTransactionModel {
  String status;
  List<GetTransactionResult> data;
  String message;

  GetTransactionModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory GetTransactionModel.fromJson(Map<String, dynamic> json) => GetTransactionModel(
    status: json["status"],
    data: List<GetTransactionResult>.from(json["data"].map((x) => GetTransactionResult.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class GetTransactionResult {
  int id;
  String driverId;
  String userId;
  String requestId;
  String amount;
  String paymentType;
  String tip;
  String status;
  DateTime dateTime;
  String timeZone;
  String picuplocation;
  String dropofflocation;

  GetTransactionResult({
    required this.id,
    required this.driverId,
    required this.userId,
    required this.requestId,
    required this.amount,
    required this.paymentType,
    required this.tip,
    required this.status,
    required this.dateTime,
    required this.timeZone,
    required this.picuplocation,
    required this.dropofflocation,
  });

  factory GetTransactionResult.fromJson(Map<String, dynamic> json) => GetTransactionResult(
    id: json["id"],
    driverId: json["driver_id"],
    userId: json["user_id"],
    requestId: json["request_id"],
    amount: json["amount"],
    paymentType: json["payment_type"],
    tip: json["tip"],
    status: json["status"],
    dateTime: DateTime.parse(json["date_time"]),
    timeZone: json["time_zone"],
    picuplocation: json["picuplocation"],
    dropofflocation: json["dropofflocation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_id": driverId,
    "user_id": userId,
    "request_id": requestId,
    "amount": amount,
    "payment_type": paymentType,
    "tip": tip,
    "status": status,
    "date_time": dateTime.toIso8601String(),
    "time_zone": timeZone,
    "picuplocation": picuplocation,
    "dropofflocation": dropofflocation,
  };
}

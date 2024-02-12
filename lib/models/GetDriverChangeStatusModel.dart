class GetDriverChangeStatusModel {
  String? status;
  String? message;
  GetDriverChangeStatusResult? result;

  GetDriverChangeStatusModel({this.status, this.message, this.result});

  GetDriverChangeStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['status'] != '0' ?GetDriverChangeStatusResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class GetDriverChangeStatusResult {
  int? id;
  String? userId;
  String? driverId;
  String? driverIds;
  String? status;
  String? picuplocation;
  String? dropofflocation;
  String? picuplat;
  String? pickuplon;
  String? droplat;
  String? droplon;
  String? sharerideType;
  String? booktype;
  String? carTypeId;
  String? carSeats;
  String? numberOfWitness;
  String? bookedSeats;
  String? reqDatetime;
  String? timezone;
  String? picklatertime;
  String? picklaterdate;
  String? routeImg;
  String? startTime;
  String? endTime;
  String? wtStartTime;
  String? wtEndTime;
  String? waitingStatus;
  String? acceptTime;
  int? waitingCnt;
  String? typeOfSigningId;
  String? applyCode;
  String? paymentType;
  String? rideFare;
  String? cardId;
  String? typeOfSigningName;
  String? companyId;
  String? numberOfSigning;
  String? carTypeName;
  String? realstateSigning;
  String? realstateSettlement;
  String? locationType;
  String? name;
  String? mobile;
  String? email;
  String? paymentStatus;
  String? userRatingStatus;
  String? uploadDocument;
  String? emailtoprit;
  String? scanandemail;
  String? prepaid;
  String? overnight;
  String? stateName;
  String? stateId;
  String? nightCharge;
  String? todayCharge;
  String? noOfHours;
  String? noOfDays;
  String? bookBy;
  String? operatorId;
  String? signingCode;
  String? notify;
  String? cardSelectStatus;
  String? cancelReaison;
  String? rushCharge;
  String? weekend;
  String? witness;
  String? express;
  String? totalAmount;
  String? statusUpdateTimeCheck;
  String? extraAmount;

  GetDriverChangeStatusResult(
      {this.id,
        this.userId,
        this.driverId,
        this.driverIds,
        this.status,
        this.picuplocation,
        this.dropofflocation,
        this.picuplat,
        this.pickuplon,
        this.droplat,
        this.droplon,
        this.sharerideType,
        this.booktype,
        this.carTypeId,
        this.carSeats,
        this.numberOfWitness,
        this.bookedSeats,
        this.reqDatetime,
        this.timezone,
        this.picklatertime,
        this.picklaterdate,
        this.routeImg,
        this.startTime,
        this.endTime,
        this.wtStartTime,
        this.wtEndTime,
        this.waitingStatus,
        this.acceptTime,
        this.waitingCnt,
        this.typeOfSigningId,
        this.applyCode,
        this.paymentType,
        this.rideFare,
        this.cardId,
        this.typeOfSigningName,
        this.companyId,
        this.numberOfSigning,
        this.carTypeName,
        this.realstateSigning,
        this.realstateSettlement,
        this.locationType,
        this.name,
        this.mobile,
        this.email,
        this.paymentStatus,
        this.userRatingStatus,
        this.uploadDocument,
        this.emailtoprit,
        this.scanandemail,
        this.prepaid,
        this.overnight,
        this.stateName,
        this.stateId,
        this.nightCharge,
        this.todayCharge,
        this.noOfHours,
        this.noOfDays,
        this.bookBy,
        this.operatorId,
        this.signingCode,
        this.notify,
        this.cardSelectStatus,
        this.cancelReaison,
        this.rushCharge,
        this.weekend,
        this.witness,
        this.express,
        this.totalAmount,
        this.statusUpdateTimeCheck,
        this.extraAmount});

  GetDriverChangeStatusResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    driverIds = json['driver_ids'];
    status = json['status'];
    picuplocation = json['picuplocation'];
    dropofflocation = json['dropofflocation'];
    picuplat = json['picuplat'];
    pickuplon = json['pickuplon'];
    droplat = json['droplat'];
    droplon = json['droplon'];
    sharerideType = json['shareride_type'];
    booktype = json['booktype'];
    carTypeId = json['car_type_id'];
    carSeats = json['car_seats'];
    numberOfWitness = json['number_of_witness'];
    bookedSeats = json['booked_seats'];
    reqDatetime = json['req_datetime'];
    timezone = json['timezone'];
    picklatertime = json['picklatertime'];
    picklaterdate = json['picklaterdate'];
    routeImg = json['route_img'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    wtStartTime = json['wt_start_time'];
    wtEndTime = json['wt_end_time'];
    waitingStatus = json['waiting_status'];
    acceptTime = json['accept_time'];
    waitingCnt = json['waiting_cnt'];
    typeOfSigningId = json['type_of_signing_id'];
    applyCode = json['apply_code'];
    paymentType = json['payment_type'];
    rideFare = json['ride_fare'];
    cardId = json['card_id'];
    typeOfSigningName = json['type_of_signing_name'];
    companyId = json['company_id'];
    numberOfSigning = json['number_of_signing'];
    carTypeName = json['car_type_name'];
    realstateSigning = json['realstate_signing'];
    realstateSettlement = json['realstate_settlement'];
    locationType = json['location_type'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    paymentStatus = json['payment_status'];
    userRatingStatus = json['user_rating_status'];
    uploadDocument = json['upload_document'];
    emailtoprit = json['emailtoprit'];
    scanandemail = json['scanandemail'];
    prepaid = json['prepaid'];
    overnight = json['overnight'];
    stateName = json['state_name'];
    stateId = json['state_id'];
    nightCharge = json['night_charge'];
    todayCharge = json['today_charge'];
    noOfHours = json['no_of_hours'];
    noOfDays = json['no_of_days'];
    bookBy = json['book_by'];
    operatorId = json['operator_id'];
    signingCode = json['signing_code'];
    notify = json['notify'];
    cardSelectStatus = json['card_select_status'];
    cancelReaison = json['cancel_reaison'];
    rushCharge = json['rush_charge'];
    weekend = json['weekend'];
    witness = json['witness'];
    express = json['express'];
    totalAmount = json['total_amount'];
    statusUpdateTimeCheck = json['status_update_time_check'];
    extraAmount = json['extra_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['driver_id'] = driverId;
    data['driver_ids'] = driverIds;
    data['status'] = status;
    data['picuplocation'] = picuplocation;
    data['dropofflocation'] = dropofflocation;
    data['picuplat'] = picuplat;
    data['pickuplon'] = pickuplon;
    data['droplat'] = droplat;
    data['droplon'] = droplon;
    data['shareride_type'] = sharerideType;
    data['booktype'] = booktype;
    data['car_type_id'] = carTypeId;
    data['car_seats'] = carSeats;
    data['number_of_witness'] = numberOfWitness;
    data['booked_seats'] = bookedSeats;
    data['req_datetime'] = reqDatetime;
    data['timezone'] = timezone;
    data['picklatertime'] = picklatertime;
    data['picklaterdate'] = picklaterdate;
    data['route_img'] = routeImg;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['wt_start_time'] = wtStartTime;
    data['wt_end_time'] = wtEndTime;
    data['waiting_status'] = waitingStatus;
    data['accept_time'] = acceptTime;
    data['waiting_cnt'] = waitingCnt;
    data['type_of_signing_id'] = typeOfSigningId;
    data['apply_code'] = applyCode;
    data['payment_type'] = paymentType;
    data['ride_fare'] = rideFare;
    data['card_id'] = cardId;
    data['type_of_signing_name'] = typeOfSigningName;
    data['company_id'] = companyId;
    data['number_of_signing'] = numberOfSigning;
    data['car_type_name'] = carTypeName;
    data['realstate_signing'] = realstateSigning;
    data['realstate_settlement'] = realstateSettlement;
    data['location_type'] = locationType;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['payment_status'] = paymentStatus;
    data['user_rating_status'] = userRatingStatus;
    data['upload_document'] = uploadDocument;
    data['emailtoprit'] = emailtoprit;
    data['scanandemail'] = scanandemail;
    data['prepaid'] = prepaid;
    data['overnight'] = overnight;
    data['state_name'] = stateName;
    data['state_id'] = stateId;
    data['night_charge'] = nightCharge;
    data['today_charge'] = todayCharge;
    data['no_of_hours'] = noOfHours;
    data['no_of_days'] = noOfDays;
    data['book_by'] = bookBy;
    data['operator_id'] = operatorId;
    data['signing_code'] = signingCode;
    data['notify'] = notify;
    data['card_select_status'] = cardSelectStatus;
    data['cancel_reaison'] = cancelReaison;
    data['rush_charge'] = rushCharge;
    data['weekend'] = weekend;
    data['witness'] = witness;
    data['express'] = express;
    data['total_amount'] = totalAmount;
    data['status_update_time_check'] = statusUpdateTimeCheck;
    data['extra_amount'] = extraAmount;
    return data;
  }
}


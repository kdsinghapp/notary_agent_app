/// status : "true"
/// data : {"id":163,"user_id":"384","driver_id":"0","driver_ids":"411","status":"Pending","picuplocation":"195, sarwasamppana nagar, Sarv Suvidha Nagar, Indore, Madhya Pradesh 452016, India","dropofflocation":null,"picuplat":"22.718991114547936","pickuplon":"75.92764656990767","droplat":null,"droplon":null,"shareride_type":"","booktype":"Now","car_type_id":"26","car_seats":"1","number_of_witness":"Yes","booked_seats":"","req_datetime":"2023-12-29 16:11:45","timezone":"Asia/Kolkata","picklatertime":"17:11:04","picklaterdate":"2023-12-22","route_img":"","start_time":"0000-00-00 00:00:00","end_time":"0000-00-00 00:00:00","wt_start_time":"0000-00-00 00:00:00","wt_end_time":"0000-00-00 00:00:00","waiting_status":"STOP","accept_time":"","waiting_cnt":0,"type_of_signing_id":"9","apply_code":"","payment_type":"Card","ride_fare":"260","card_id":null,"type_of_signing_name":"Jurats","company_id":"","number_of_signing":"13","car_type_name":"Real Estate","realstate_signing":"Yes","realstate_settlement":"Yes","location_type":"Court House","name":"google doc","mobile":"8888585858","email":null,"payment_status":"Pending","user_rating_status":"No","upload_document":null,"emailtoprit":"25","scanandemail":"25","prepaid":"0","overnight":"45","state_name":null,"state_id":"9","night_charge":"0","today_charge":"0","no_of_hours":null,"no_of_days":null,"book_by":"App","operator_id":"","signing_code":"","notify":"No","card_select_status":"No","cancel_reaison":"","rush_charge":"0","weekend":"yes","witness":"no","express":"","estimate_time":0,"estimate_distance":"0"}
/// message : "successfully"

class GetAllBookingModel {
  GetAllBookingModel({
      String? status,
    GetAllBookingResult? data,
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetAllBookingModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? GetAllBookingResult.fromJson(json['data']) : null;
    _message = json['message'];
  }
  String? _status;
  GetAllBookingResult? _data;
  String? _message;
GetAllBookingModel copyWith({  String? status,
  GetAllBookingResult? data,
  String? message,
}) => GetAllBookingModel(  status: status ?? _status,
  data: data ?? _data,
  message: message ?? _message,
);
  String? get status => _status;
  GetAllBookingResult? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

class GetAllBookingResult {
  GetAllBookingResult({
      num? id, 
      String? userId, 
      String? driverId, 
      String? driverIds, 
      String? status, 
      String? picuplocation, 
      dynamic dropofflocation, 
      String? picuplat, 
      String? pickuplon, 
      dynamic droplat, 
      dynamic droplon, 
      String? sharerideType, 
      String? booktype, 
      String? carTypeId, 
      String? carSeats, 
      String? numberOfWitness, 
      String? bookedSeats, 
      String? reqDatetime, 
      String? timezone, 
      String? picklatertime, 
      String? picklaterdate, 
      String? routeImg, 
      String? startTime, 
      String? endTime, 
      String? wtStartTime, 
      String? wtEndTime, 
      String? waitingStatus, 
      String? acceptTime, 
      num? waitingCnt, 
      String? typeOfSigningId, 
      String? applyCode, 
      String? paymentType, 
      String? rideFare, 
      dynamic cardId, 
      String? typeOfSigningName, 
      String? companyId, 
      String? numberOfSigning, 
      String? carTypeName, 
      String? realstateSigning, 
      String? realstateSettlement, 
      String? locationType, 
      String? name, 
      String? mobile, 
      dynamic email, 
      String? paymentStatus, 
      String? userRatingStatus, 
      dynamic uploadDocument, 
      String? emailtoprit, 
      String? scanandemail, 
      String? prepaid, 
      String? overnight, 
      dynamic stateName, 
      String? stateId, 
      String? nightCharge, 
      String? todayCharge, 
      dynamic noOfHours, 
      dynamic noOfDays, 
      String? bookBy, 
      String? operatorId, 
      String? signingCode, 
      String? notify, 
      String? cardSelectStatus, 
      String? cancelReaison, 
      String? rushCharge, 
      String? weekend, 
      String? witness, 
      String? express, 
      num? estimateTime, 
      String? estimateDistance,}){
    _id = id;
    _userId = userId;
    _driverId = driverId;
    _driverIds = driverIds;
    _status = status;
    _picuplocation = picuplocation;
    _dropofflocation = dropofflocation;
    _picuplat = picuplat;
    _pickuplon = pickuplon;
    _droplat = droplat;
    _droplon = droplon;
    _sharerideType = sharerideType;
    _booktype = booktype;
    _carTypeId = carTypeId;
    _carSeats = carSeats;
    _numberOfWitness = numberOfWitness;
    _bookedSeats = bookedSeats;
    _reqDatetime = reqDatetime;
    _timezone = timezone;
    _picklatertime = picklatertime;
    _picklaterdate = picklaterdate;
    _routeImg = routeImg;
    _startTime = startTime;
    _endTime = endTime;
    _wtStartTime = wtStartTime;
    _wtEndTime = wtEndTime;
    _waitingStatus = waitingStatus;
    _acceptTime = acceptTime;
    _waitingCnt = waitingCnt;
    _typeOfSigningId = typeOfSigningId;
    _applyCode = applyCode;
    _paymentType = paymentType;
    _rideFare = rideFare;
    _cardId = cardId;
    _typeOfSigningName = typeOfSigningName;
    _companyId = companyId;
    _numberOfSigning = numberOfSigning;
    _carTypeName = carTypeName;
    _realstateSigning = realstateSigning;
    _realstateSettlement = realstateSettlement;
    _locationType = locationType;
    _name = name;
    _mobile = mobile;
    _email = email;
    _paymentStatus = paymentStatus;
    _userRatingStatus = userRatingStatus;
    _uploadDocument = uploadDocument;
    _emailtoprit = emailtoprit;
    _scanandemail = scanandemail;
    _prepaid = prepaid;
    _overnight = overnight;
    _stateName = stateName;
    _stateId = stateId;
    _nightCharge = nightCharge;
    _todayCharge = todayCharge;
    _noOfHours = noOfHours;
    _noOfDays = noOfDays;
    _bookBy = bookBy;
    _operatorId = operatorId;
    _signingCode = signingCode;
    _notify = notify;
    _cardSelectStatus = cardSelectStatus;
    _cancelReaison = cancelReaison;
    _rushCharge = rushCharge;
    _weekend = weekend;
    _witness = witness;
    _express = express;
    _estimateTime = estimateTime;
    _estimateDistance = estimateDistance;
}

  GetAllBookingResult.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _driverId = json['driver_id'];
    _driverIds = json['driver_ids'];
    _status = json['status'];
    _picuplocation = json['picuplocation'];
    _dropofflocation = json['dropofflocation'];
    _picuplat = json['picuplat'];
    _pickuplon = json['pickuplon'];
    _droplat = json['droplat'];
    _droplon = json['droplon'];
    _sharerideType = json['shareride_type'];
    _booktype = json['booktype'];
    _carTypeId = json['car_type_id'];
    _carSeats = json['car_seats'];
    _numberOfWitness = json['number_of_witness'];
    _bookedSeats = json['booked_seats'];
    _reqDatetime = json['req_datetime'];
    _timezone = json['timezone'];
    _picklatertime = json['picklatertime'];
    _picklaterdate = json['picklaterdate'];
    _routeImg = json['route_img'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _wtStartTime = json['wt_start_time'];
    _wtEndTime = json['wt_end_time'];
    _waitingStatus = json['waiting_status'];
    _acceptTime = json['accept_time'];
    _waitingCnt = json['waiting_cnt'];
    _typeOfSigningId = json['type_of_signing_id'];
    _applyCode = json['apply_code'];
    _paymentType = json['payment_type'];
    _rideFare = json['ride_fare'];
    _cardId = json['card_id'];
    _typeOfSigningName = json['type_of_signing_name'];
    _companyId = json['company_id'];
    _numberOfSigning = json['number_of_signing'];
    _carTypeName = json['car_type_name'];
    _realstateSigning = json['realstate_signing'];
    _realstateSettlement = json['realstate_settlement'];
    _locationType = json['location_type'];
    _name = json['name'];
    _mobile = json['mobile'];
    _email = json['email'];
    _paymentStatus = json['payment_status'];
    _userRatingStatus = json['user_rating_status'];
    _uploadDocument = json['upload_document'];
    _emailtoprit = json['emailtoprit'];
    _scanandemail = json['scanandemail'];
    _prepaid = json['prepaid'];
    _overnight = json['overnight'];
    _stateName = json['state_name'];
    _stateId = json['state_id'];
    _nightCharge = json['night_charge'];
    _todayCharge = json['today_charge'];
    _noOfHours = json['no_of_hours'];
    _noOfDays = json['no_of_days'];
    _bookBy = json['book_by'];
    _operatorId = json['operator_id'];
    _signingCode = json['signing_code'];
    _notify = json['notify'];
    _cardSelectStatus = json['card_select_status'];
    _cancelReaison = json['cancel_reaison'];
    _rushCharge = json['rush_charge'];
    _weekend = json['weekend'];
    _witness = json['witness'];
    _express = json['express'];
    _estimateTime = json['estimate_time'];
    _estimateDistance = json['estimate_distance'];
  }
  num? _id;
  String? _userId;
  String? _driverId;
  String? _driverIds;
  String? _status;
  String? _picuplocation;
  dynamic _dropofflocation;
  String? _picuplat;
  String? _pickuplon;
  dynamic _droplat;
  dynamic _droplon;
  String? _sharerideType;
  String? _booktype;
  String? _carTypeId;
  String? _carSeats;
  String? _numberOfWitness;
  String? _bookedSeats;
  String? _reqDatetime;
  String? _timezone;
  String? _picklatertime;
  String? _picklaterdate;
  String? _routeImg;
  String? _startTime;
  String? _endTime;
  String? _wtStartTime;
  String? _wtEndTime;
  String? _waitingStatus;
  String? _acceptTime;
  num? _waitingCnt;
  String? _typeOfSigningId;
  String? _applyCode;
  String? _paymentType;
  String? _rideFare;
  dynamic _cardId;
  String? _typeOfSigningName;
  String? _companyId;
  String? _numberOfSigning;
  String? _carTypeName;
  String? _realstateSigning;
  String? _realstateSettlement;
  String? _locationType;
  String? _name;
  String? _mobile;
  dynamic _email;
  String? _paymentStatus;
  String? _userRatingStatus;
  dynamic _uploadDocument;
  String? _emailtoprit;
  String? _scanandemail;
  String? _prepaid;
  String? _overnight;
  dynamic _stateName;
  String? _stateId;
  String? _nightCharge;
  String? _todayCharge;
  dynamic _noOfHours;
  dynamic _noOfDays;
  String? _bookBy;
  String? _operatorId;
  String? _signingCode;
  String? _notify;
  String? _cardSelectStatus;
  String? _cancelReaison;
  String? _rushCharge;
  String? _weekend;
  String? _witness;
  String? _express;
  num? _estimateTime;
  String? _estimateDistance;
  GetAllBookingResult copyWith({  num? id,
  String? userId,
  String? driverId,
  String? driverIds,
  String? status,
  String? picuplocation,
  dynamic dropofflocation,
  String? picuplat,
  String? pickuplon,
  dynamic droplat,
  dynamic droplon,
  String? sharerideType,
  String? booktype,
  String? carTypeId,
  String? carSeats,
  String? numberOfWitness,
  String? bookedSeats,
  String? reqDatetime,
  String? timezone,
  String? picklatertime,
  String? picklaterdate,
  String? routeImg,
  String? startTime,
  String? endTime,
  String? wtStartTime,
  String? wtEndTime,
  String? waitingStatus,
  String? acceptTime,
  num? waitingCnt,
  String? typeOfSigningId,
  String? applyCode,
  String? paymentType,
  String? rideFare,
  dynamic cardId,
  String? typeOfSigningName,
  String? companyId,
  String? numberOfSigning,
  String? carTypeName,
  String? realstateSigning,
  String? realstateSettlement,
  String? locationType,
  String? name,
  String? mobile,
  dynamic email,
  String? paymentStatus,
  String? userRatingStatus,
  dynamic uploadDocument,
  String? emailtoprit,
  String? scanandemail,
  String? prepaid,
  String? overnight,
  dynamic stateName,
  String? stateId,
  String? nightCharge,
  String? todayCharge,
  dynamic noOfHours,
  dynamic noOfDays,
  String? bookBy,
  String? operatorId,
  String? signingCode,
  String? notify,
  String? cardSelectStatus,
  String? cancelReaison,
  String? rushCharge,
  String? weekend,
  String? witness,
  String? express,
  num? estimateTime,
  String? estimateDistance,
}) => GetAllBookingResult(  id: id ?? _id,
  userId: userId ?? _userId,
  driverId: driverId ?? _driverId,
  driverIds: driverIds ?? _driverIds,
  status: status ?? _status,
  picuplocation: picuplocation ?? _picuplocation,
  dropofflocation: dropofflocation ?? _dropofflocation,
  picuplat: picuplat ?? _picuplat,
  pickuplon: pickuplon ?? _pickuplon,
  droplat: droplat ?? _droplat,
  droplon: droplon ?? _droplon,
  sharerideType: sharerideType ?? _sharerideType,
  booktype: booktype ?? _booktype,
  carTypeId: carTypeId ?? _carTypeId,
  carSeats: carSeats ?? _carSeats,
  numberOfWitness: numberOfWitness ?? _numberOfWitness,
  bookedSeats: bookedSeats ?? _bookedSeats,
  reqDatetime: reqDatetime ?? _reqDatetime,
  timezone: timezone ?? _timezone,
  picklatertime: picklatertime ?? _picklatertime,
  picklaterdate: picklaterdate ?? _picklaterdate,
  routeImg: routeImg ?? _routeImg,
  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
  wtStartTime: wtStartTime ?? _wtStartTime,
  wtEndTime: wtEndTime ?? _wtEndTime,
  waitingStatus: waitingStatus ?? _waitingStatus,
  acceptTime: acceptTime ?? _acceptTime,
  waitingCnt: waitingCnt ?? _waitingCnt,
  typeOfSigningId: typeOfSigningId ?? _typeOfSigningId,
  applyCode: applyCode ?? _applyCode,
  paymentType: paymentType ?? _paymentType,
  rideFare: rideFare ?? _rideFare,
  cardId: cardId ?? _cardId,
  typeOfSigningName: typeOfSigningName ?? _typeOfSigningName,
  companyId: companyId ?? _companyId,
  numberOfSigning: numberOfSigning ?? _numberOfSigning,
  carTypeName: carTypeName ?? _carTypeName,
  realstateSigning: realstateSigning ?? _realstateSigning,
  realstateSettlement: realstateSettlement ?? _realstateSettlement,
  locationType: locationType ?? _locationType,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  email: email ?? _email,
  paymentStatus: paymentStatus ?? _paymentStatus,
  userRatingStatus: userRatingStatus ?? _userRatingStatus,
  uploadDocument: uploadDocument ?? _uploadDocument,
  emailtoprit: emailtoprit ?? _emailtoprit,
  scanandemail: scanandemail ?? _scanandemail,
  prepaid: prepaid ?? _prepaid,
  overnight: overnight ?? _overnight,
  stateName: stateName ?? _stateName,
  stateId: stateId ?? _stateId,
  nightCharge: nightCharge ?? _nightCharge,
  todayCharge: todayCharge ?? _todayCharge,
  noOfHours: noOfHours ?? _noOfHours,
  noOfDays: noOfDays ?? _noOfDays,
  bookBy: bookBy ?? _bookBy,
  operatorId: operatorId ?? _operatorId,
  signingCode: signingCode ?? _signingCode,
  notify: notify ?? _notify,
  cardSelectStatus: cardSelectStatus ?? _cardSelectStatus,
  cancelReaison: cancelReaison ?? _cancelReaison,
  rushCharge: rushCharge ?? _rushCharge,
  weekend: weekend ?? _weekend,
  witness: witness ?? _witness,
  express: express ?? _express,
  estimateTime: estimateTime ?? _estimateTime,
  estimateDistance: estimateDistance ?? _estimateDistance,
);
  num? get id => _id;
  String? get userId => _userId;
  String? get driverId => _driverId;
  String? get driverIds => _driverIds;
  String? get status => _status;
  String? get picuplocation => _picuplocation;
  dynamic get dropofflocation => _dropofflocation;
  String? get picuplat => _picuplat;
  String? get pickuplon => _pickuplon;
  dynamic get droplat => _droplat;
  dynamic get droplon => _droplon;
  String? get sharerideType => _sharerideType;
  String? get booktype => _booktype;
  String? get carTypeId => _carTypeId;
  String? get carSeats => _carSeats;
  String? get numberOfWitness => _numberOfWitness;
  String? get bookedSeats => _bookedSeats;
  String? get reqDatetime => _reqDatetime;
  String? get timezone => _timezone;
  String? get picklatertime => _picklatertime;
  String? get picklaterdate => _picklaterdate;
  String? get routeImg => _routeImg;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get wtStartTime => _wtStartTime;
  String? get wtEndTime => _wtEndTime;
  String? get waitingStatus => _waitingStatus;
  String? get acceptTime => _acceptTime;
  num? get waitingCnt => _waitingCnt;
  String? get typeOfSigningId => _typeOfSigningId;
  String? get applyCode => _applyCode;
  String? get paymentType => _paymentType;
  String? get rideFare => _rideFare;
  dynamic get cardId => _cardId;
  String? get typeOfSigningName => _typeOfSigningName;
  String? get companyId => _companyId;
  String? get numberOfSigning => _numberOfSigning;
  String? get carTypeName => _carTypeName;
  String? get realstateSigning => _realstateSigning;
  String? get realstateSettlement => _realstateSettlement;
  String? get locationType => _locationType;
  String? get name => _name;
  String? get mobile => _mobile;
  dynamic get email => _email;
  String? get paymentStatus => _paymentStatus;
  String? get userRatingStatus => _userRatingStatus;
  dynamic get uploadDocument => _uploadDocument;
  String? get emailtoprit => _emailtoprit;
  String? get scanandemail => _scanandemail;
  String? get prepaid => _prepaid;
  String? get overnight => _overnight;
  dynamic get stateName => _stateName;
  String? get stateId => _stateId;
  String? get nightCharge => _nightCharge;
  String? get todayCharge => _todayCharge;
  dynamic get noOfHours => _noOfHours;
  dynamic get noOfDays => _noOfDays;
  String? get bookBy => _bookBy;
  String? get operatorId => _operatorId;
  String? get signingCode => _signingCode;
  String? get notify => _notify;
  String? get cardSelectStatus => _cardSelectStatus;
  String? get cancelReaison => _cancelReaison;
  String? get rushCharge => _rushCharge;
  String? get weekend => _weekend;
  String? get witness => _witness;
  String? get express => _express;
  num? get estimateTime => _estimateTime;
  String? get estimateDistance => _estimateDistance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['driver_id'] = _driverId;
    map['driver_ids'] = _driverIds;
    map['status'] = _status;
    map['picuplocation'] = _picuplocation;
    map['dropofflocation'] = _dropofflocation;
    map['picuplat'] = _picuplat;
    map['pickuplon'] = _pickuplon;
    map['droplat'] = _droplat;
    map['droplon'] = _droplon;
    map['shareride_type'] = _sharerideType;
    map['booktype'] = _booktype;
    map['car_type_id'] = _carTypeId;
    map['car_seats'] = _carSeats;
    map['number_of_witness'] = _numberOfWitness;
    map['booked_seats'] = _bookedSeats;
    map['req_datetime'] = _reqDatetime;
    map['timezone'] = _timezone;
    map['picklatertime'] = _picklatertime;
    map['picklaterdate'] = _picklaterdate;
    map['route_img'] = _routeImg;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['wt_start_time'] = _wtStartTime;
    map['wt_end_time'] = _wtEndTime;
    map['waiting_status'] = _waitingStatus;
    map['accept_time'] = _acceptTime;
    map['waiting_cnt'] = _waitingCnt;
    map['type_of_signing_id'] = _typeOfSigningId;
    map['apply_code'] = _applyCode;
    map['payment_type'] = _paymentType;
    map['ride_fare'] = _rideFare;
    map['card_id'] = _cardId;
    map['type_of_signing_name'] = _typeOfSigningName;
    map['company_id'] = _companyId;
    map['number_of_signing'] = _numberOfSigning;
    map['car_type_name'] = _carTypeName;
    map['realstate_signing'] = _realstateSigning;
    map['realstate_settlement'] = _realstateSettlement;
    map['location_type'] = _locationType;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['payment_status'] = _paymentStatus;
    map['user_rating_status'] = _userRatingStatus;
    map['upload_document'] = _uploadDocument;
    map['emailtoprit'] = _emailtoprit;
    map['scanandemail'] = _scanandemail;
    map['prepaid'] = _prepaid;
    map['overnight'] = _overnight;
    map['state_name'] = _stateName;
    map['state_id'] = _stateId;
    map['night_charge'] = _nightCharge;
    map['today_charge'] = _todayCharge;
    map['no_of_hours'] = _noOfHours;
    map['no_of_days'] = _noOfDays;
    map['book_by'] = _bookBy;
    map['operator_id'] = _operatorId;
    map['signing_code'] = _signingCode;
    map['notify'] = _notify;
    map['card_select_status'] = _cardSelectStatus;
    map['cancel_reaison'] = _cancelReaison;
    map['rush_charge'] = _rushCharge;
    map['weekend'] = _weekend;
    map['witness'] = _witness;
    map['express'] = _express;
    map['estimate_time'] = _estimateTime;
    map['estimate_distance'] = _estimateDistance;
    return map;
  }

}
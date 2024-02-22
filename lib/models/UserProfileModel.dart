class UserProfileModel {
  String? status;
  List<UserProfileData>? data;
  String? message;

  UserProfileModel({this.status, this.data, this.message});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <UserProfileData>[];
      json['data'].forEach((v) {
        data!.add(new UserProfileData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class UserProfileData {
  int? id;
  String? type;
  String? firstName;
  String? lastName;
  String? email;
  String? address;
  String? zipcode;
  String? country;
  String? state;
  String? city;
  String? carColor;
  String? carNumber;
  String? carModel;
  String? license;
  String? onlineStatus;
  String? carDocument;
  String? carTypeId;
  String? mobile;
  String? userPdf;
  String? yearOfManufacture;
  String? carImage;
  String? image;
  int? status;
  String? isAdmin;
  String? password;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? custId;
  String? emailVerifiedAt;
  String? name;
  String? stripeAccountId;
  String? iosRegisterId;
  String? stripeAccountLoginLink;
  String? phoneCode;
  String? socialId;
  String? lat;
  String? lon;
  String? registerId;
  String? carId;
  String? wallet;
  String? verifyCode;
  String? lang;
  String? currency;
  String? place;
  String? promoCode;
  String? amount;
  String? rideEarning;
  String? ridePendingAmt;
  String? nxnPoint;
  String? licenceIssueDate;
  String? licenceExpiryDate;
  String? licenseState;
  String? insurance;
  String? document;
  String? inviteEarning;
  String? identity;
  String? langId;
  String? activity;
  String? badge;
  String? unitNumber;
  String? companyName;
  String? companyCode;
  String? costCenterCode;
  String? maxCareer;
  String? pin;
  String? stateLicenced;
  String? signupMobilityStatus;
  String? curentlyMobileNotary;
  String? realestate;
  String? numberOfYears;
  String? approvedStartImmediately;
  String? nnaCertifiedWithBackCheck;
  String? eAndOEnsurance;
  String? insuranceProducerLicenses;
  String? distance;
  String? referralCode;
  String? stripeAccountEmail;
  String? passkey;
  String? oauthProvider;
  String? oauthUid;
  String? dateTime;
  String? countryCode;
  int? agentStep1;
  int? agentStep2;
  int? agentStep3;
  int? agentStep4;
  int? agentStep5;
  String? agentDrivingImageFront;
  String? agentDrivingImageBack;
  String? copyOfBond;
  String? copyOfNotary;
  String? copyOfBackground;
  String? middleName;
  String? suite;
  String? county;
  String? alternateNumber;
  String? websiteUrl;
  String? generalInformation;
  String? notaryLicenseOrCommissionNumber;
  String? issuedDate;
  String? expirationDate;
  String? otherThanEnglishTextarea;
  String? stripAccountId;
  String? stripAccountType;
  String? stripAccountCategory;
  String? stripAttemptAccountId;
  String? stripAccountIdStatusByStripe;
  int? agentStep1Admin;
  int? agentStep2Admin;
  int? agentStep3Admin;
  int? agentStep4Admin;
  int? agentStep5Admin;
  String? agentStep1AdminComment;
  String? agentStep2AdminComment;
  String? agentStep3AdminComment;
  String? agentStep4AdminComment;
  String? agentStep5AdminComment;
  String? webTokenDevice;
  String? stripeCustomerId;
  String? stripLoginLinkInStripeWebsite;
  double? review;

  UserProfileData(
      {this.id,
        this.type,
        this.firstName,
        this.lastName,
        this.email,
        this.address,
        this.zipcode,
        this.country,
        this.state,
        this.city,
        this.carColor,
        this.carNumber,
        this.carModel,
        this.license,
        this.onlineStatus,
        this.carDocument,
        this.carTypeId,
        this.mobile,
        this.userPdf,
        this.yearOfManufacture,
        this.carImage,
        this.image,
        this.status,
        this.isAdmin,
        this.password,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.custId,
        this.emailVerifiedAt,
        this.name,
        this.stripeAccountId,
        this.iosRegisterId,
        this.stripeAccountLoginLink,
        this.phoneCode,
        this.socialId,
        this.lat,
        this.lon,
        this.registerId,
        this.carId,
        this.wallet,
        this.verifyCode,
        this.lang,
        this.currency,
        this.place,
        this.promoCode,
        this.amount,
        this.rideEarning,
        this.ridePendingAmt,
        this.nxnPoint,
        this.licenceIssueDate,
        this.licenceExpiryDate,
        this.licenseState,
        this.insurance,
        this.document,
        this.inviteEarning,
        this.identity,
        this.langId,
        this.activity,
        this.badge,
        this.unitNumber,
        this.companyName,
        this.companyCode,
        this.costCenterCode,
        this.maxCareer,
        this.pin,
        this.stateLicenced,
        this.signupMobilityStatus,
        this.curentlyMobileNotary,
        this.realestate,
        this.numberOfYears,
        this.approvedStartImmediately,
        this.nnaCertifiedWithBackCheck,
        this.eAndOEnsurance,
        this.insuranceProducerLicenses,
        this.distance,
        this.referralCode,
        this.stripeAccountEmail,
        this.passkey,
        this.oauthProvider,
        this.oauthUid,
        this.dateTime,
        this.countryCode,
        this.agentStep1,
        this.agentStep2,
        this.agentStep3,
        this.agentStep4,
        this.agentStep5,
        this.agentDrivingImageFront,
        this.agentDrivingImageBack,
        this.copyOfBond,
        this.copyOfNotary,
        this.copyOfBackground,
        this.middleName,
        this.suite,
        this.county,
        this.alternateNumber,
        this.websiteUrl,
        this.generalInformation,
        this.notaryLicenseOrCommissionNumber,
        this.issuedDate,
        this.expirationDate,
        this.otherThanEnglishTextarea,
        this.stripAccountId,
        this.stripAccountType,
        this.stripAccountCategory,
        this.stripAttemptAccountId,
        this.stripAccountIdStatusByStripe,
        this.agentStep1Admin,
        this.agentStep2Admin,
        this.agentStep3Admin,
        this.agentStep4Admin,
        this.agentStep5Admin,
        this.agentStep1AdminComment,
        this.agentStep2AdminComment,
        this.agentStep3AdminComment,
        this.agentStep4AdminComment,
        this.agentStep5AdminComment,
        this.webTokenDevice,
        this.stripeCustomerId,
        this.stripLoginLinkInStripeWebsite,
        this.review});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    address = json['address'];
    zipcode = json['zipcode'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    carColor = json['car_color'];
    carNumber = json['car_number'];
    carModel = json['car_model'];
    license = json['license'];
    onlineStatus = json['online_status'];
    carDocument = json['car_document'];
    carTypeId = json['car_type_id'];
    mobile = json['mobile'];
    userPdf = json['user_pdf'];
    yearOfManufacture = json['year_of_manufacture'];
    carImage = json['car_image'];
    image = json['image'];
    status = json['status'];
    isAdmin = json['is_admin'];
    password = json['password'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    custId = json['cust_id'];
    emailVerifiedAt = json['email_verified_at'];
    name = json['name'];
    stripeAccountId = json['stripe_account_id'];
    iosRegisterId = json['ios_register_id'];
    stripeAccountLoginLink = json['stripe_account_login_link'];
    phoneCode = json['phone_code'];
    socialId = json['social_id'];
    lat = json['lat'];
    lon = json['lon'];
    registerId = json['register_id'];
    carId = json['car_id'];
    wallet = json['wallet'];
    verifyCode = json['verify_code'];
    lang = json['lang'];
    currency = json['currency'];
    place = json['place'];
    promoCode = json['promo_code'];
    amount = json['amount'];
    rideEarning = json['ride_earning'];
    ridePendingAmt = json['ride_pending_amt'];
    nxnPoint = json['nxn_point'];
    licenceIssueDate = json['licence_issue_date'];
    licenceExpiryDate = json['licence_expiry_date'];
    licenseState = json['license_state'];
    insurance = json['insurance'];
    document = json['document'];
    inviteEarning = json['invite_earning'];
    identity = json['identity'];
    langId = json['lang_id'];
    activity = json['activity'];
    badge = json['badge'];
    unitNumber = json['unit_number'];
    companyName = json['company_name'];
    companyCode = json['company_code'];
    costCenterCode = json['cost_center_code'];
    maxCareer = json['max_career'];
    pin = json['pin'];
    stateLicenced = json['state_licenced'];
    signupMobilityStatus = json['signup_mobility_status'];
    curentlyMobileNotary = json['curently_mobile_notary'];
    realestate = json['realestate'];
    numberOfYears = json['number_of_years'];
    approvedStartImmediately = json['approved_start_immediately'];
    nnaCertifiedWithBackCheck = json['nna_certified_with_back_check'];
    eAndOEnsurance = json['e_and_o_ensurance'];
    insuranceProducerLicenses = json['insurance_producer_licenses'];
    distance = json['distance'];
    referralCode = json['referral_code'];
    stripeAccountEmail = json['stripe_account_email'];
    passkey = json['passkey'];
    oauthProvider = json['oauth_provider'];
    oauthUid = json['oauth_uid'];
    dateTime = json['date_time'];
    countryCode = json['country_code'];
    agentStep1 = json['agent_step_1'];
    agentStep2 = json['agent_step_2'];
    agentStep3 = json['agent_step_3'];
    agentStep4 = json['agent_step_4'];
    agentStep5 = json['agent_step_5'];
    agentDrivingImageFront = json['agent_driving_image_front'];
    agentDrivingImageBack = json['agent_driving_image_back'];
    copyOfBond = json['copy_of_bond'];
    copyOfNotary = json['copy_of_notary'];
    copyOfBackground = json['copy_of_background'];
    middleName = json['middle_name'];
    suite = json['suite'];
    county = json['county'];
    alternateNumber = json['alternate_number'];
    websiteUrl = json['website_url'];
    generalInformation = json['general_information'];
    notaryLicenseOrCommissionNumber =
    json['notary_license_or_commission_number'];
    issuedDate = json['issued_date'];
    expirationDate = json['expiration_date'];
    otherThanEnglishTextarea = json['other_than_english_textarea'];
    stripAccountId = json['strip_account_Id'];
    stripAccountType = json['strip_account_type'];
    stripAccountCategory = json['strip_account_category'];
    stripAttemptAccountId = json['strip_attempt_account_Id'];
    stripAccountIdStatusByStripe = json['strip_account_Id_status_by_stripe'];
    agentStep1Admin = json['agent_step_1_admin'];
    agentStep2Admin = json['agent_step_2_admin'];
    agentStep3Admin = json['agent_step_3_admin'];
    agentStep4Admin = json['agent_step_4_admin'];
    agentStep5Admin = json['agent_step_5_admin'];
    agentStep1AdminComment = json['agent_step_1_admin_comment'];
    agentStep2AdminComment = json['agent_step_2_admin_comment'];
    agentStep3AdminComment = json['agent_step_3_admin_comment'];
    agentStep4AdminComment = json['agent_step_4_admin_comment'];
    agentStep5AdminComment = json['agent_step_5_admin_comment'];
    webTokenDevice = json['web_token_device'];
    stripeCustomerId = json['stripe_customer_id'];
    stripLoginLinkInStripeWebsite = json['strip_login_link_in_stripe_website'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['address'] = address;
    data['zipcode'] = zipcode;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['car_color'] = carColor;
    data['car_number'] = carNumber;
    data['car_model'] = carModel;
    data['license'] = license;
    data['online_status'] = onlineStatus;
    data['car_document'] = carDocument;
    data['car_type_id'] = carTypeId;
    data['mobile'] = mobile;
    data['user_pdf'] = userPdf;
    data['year_of_manufacture'] = yearOfManufacture;
    data['car_image'] = carImage;
    data['image'] = image;
    data['status'] = status;
    data['is_admin'] = isAdmin;
    data['password'] = password;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cust_id'] = custId;
    data['email_verified_at'] = emailVerifiedAt;
    data['name'] = name;
    data['stripe_account_id'] = stripeAccountId;
    data['ios_register_id'] = iosRegisterId;
    data['stripe_account_login_link'] = stripeAccountLoginLink;
    data['phone_code'] = phoneCode;
    data['social_id'] = socialId;
    data['lat'] = lat;
    data['lon'] = lon;
    data['register_id'] = registerId;
    data['car_id'] = carId;
    data['wallet'] = wallet;
    data['verify_code'] = verifyCode;
    data['lang'] = lang;
    data['currency'] = currency;
    data['place'] = place;
    data['promo_code'] = promoCode;
    data['amount'] = amount;
    data['ride_earning'] = rideEarning;
    data['ride_pending_amt'] = ridePendingAmt;
    data['nxn_point'] = nxnPoint;
    data['licence_issue_date'] = licenceIssueDate;
    data['licence_expiry_date'] = licenceExpiryDate;
    data['license_state'] = licenseState;
    data['insurance'] = insurance;
    data['document'] = document;
    data['invite_earning'] = inviteEarning;
    data['identity'] = identity;
    data['lang_id'] = langId;
    data['activity'] = activity;
    data['badge'] = badge;
    data['unit_number'] = unitNumber;
    data['company_name'] = companyName;
    data['company_code'] = companyCode;
    data['cost_center_code'] = costCenterCode;
    data['max_career'] = maxCareer;
    data['pin'] = pin;
    data['state_licenced'] = stateLicenced;
    data['signup_mobility_status'] = signupMobilityStatus;
    data['curently_mobile_notary'] = curentlyMobileNotary;
    data['realestate'] = realestate;
    data['number_of_years'] = numberOfYears;
    data['approved_start_immediately'] = approvedStartImmediately;
    data['nna_certified_with_back_check'] = nnaCertifiedWithBackCheck;
    data['e_and_o_ensurance'] = eAndOEnsurance;
    data['insurance_producer_licenses'] = insuranceProducerLicenses;
    data['distance'] = distance;
    data['referral_code'] = referralCode;
    data['stripe_account_email'] = stripeAccountEmail;
    data['passkey'] = passkey;
    data['oauth_provider'] = oauthProvider;
    data['oauth_uid'] = oauthUid;
    data['date_time'] = dateTime;
    data['country_code'] = countryCode;
    data['agent_step_1'] = agentStep1;
    data['agent_step_2'] = agentStep2;
    data['agent_step_3'] = agentStep3;
    data['agent_step_4'] = agentStep4;
    data['agent_step_5'] = agentStep5;
    data['agent_driving_image_front'] = agentDrivingImageFront;
    data['agent_driving_image_back'] = agentDrivingImageBack;
    data['copy_of_bond'] = copyOfBond;
    data['copy_of_notary'] = copyOfNotary;
    data['copy_of_background'] = copyOfBackground;
    data['middle_name'] = middleName;
    data['suite'] = suite;
    data['county'] = county;
    data['alternate_number'] = alternateNumber;
    data['website_url'] = websiteUrl;
    data['general_information'] = generalInformation;
    data['notary_license_or_commission_number'] =
        notaryLicenseOrCommissionNumber;
    data['issued_date'] = issuedDate;
    data['expiration_date'] = expirationDate;
    data['other_than_english_textarea'] = otherThanEnglishTextarea;
    data['strip_account_Id'] = stripAccountId;
    data['strip_account_type'] = stripAccountType;
    data['strip_account_category'] = stripAccountCategory;
    data['strip_attempt_account_Id'] = stripAttemptAccountId;
    data['strip_account_Id_status_by_stripe'] =
        stripAccountIdStatusByStripe;
    data['agent_step_1_admin'] = agentStep1Admin;
    data['agent_step_2_admin'] = agentStep2Admin;
    data['agent_step_3_admin'] = agentStep3Admin;
    data['agent_step_4_admin'] = agentStep4Admin;
    data['agent_step_5_admin'] = agentStep5Admin;
    data['agent_step_1_admin_comment'] = agentStep1AdminComment;
    data['agent_step_2_admin_comment'] = agentStep2AdminComment;
    data['agent_step_3_admin_comment'] = agentStep3AdminComment;
    data['agent_step_4_admin_comment'] = agentStep4AdminComment;
    data['agent_step_5_admin_comment'] = agentStep5AdminComment;
    data['web_token_device'] = webTokenDevice;
    data['stripe_customer_id'] = stripeCustomerId;
    data['strip_login_link_in_stripe_website'] =
        stripLoginLinkInStripeWebsite;
    data['review'] = review;
    return data;
  }
}

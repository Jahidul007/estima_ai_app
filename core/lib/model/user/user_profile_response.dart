import 'package:core/model/base_response.dart';
import 'package:core/model/user/key_document_item.dart';
import 'package:dio/dio.dart';

class UserProfileResponse extends BaseResponse {
  String? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  bool? emailVerified;
  String? type;
  String? countryCode;
  String? phoneNumber;
  String? kycLevel;
  String? status;
  String? nationalId;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? cityId;
  String? state;
  String? profilePictureUrl;
  String? stateId;
  String? zipCode;
  String? country;
  String? countryId;
  List<UserKycDocuments>? userKycDocuments;
  String? idpId;
  String? customerTableId;
  String? kycInfoId;
  String? activeKycInfoId;
  String? kycStatusUpdateRequestDto;
  String? transactionProfileId;
  String? transactionProfileName;
  String? feeProfileId;
  String? feeProfileName;
  String? qrCodeString;
  String? surveyName;
  String? surveyNote;


  UserProfileResponse(
      {this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.email,
      this.emailVerified,
      this.type,
      this.countryCode,
      this.phoneNumber,
      this.kycLevel,
      this.status,
      this.nationalId,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.cityId,
      this.state,
      this.profilePictureUrl,
      this.stateId,
      this.zipCode,
      this.country,
      this.countryId,
      this.userKycDocuments,
      this.idpId,
      this.customerTableId,
      this.kycInfoId,
      this.activeKycInfoId,
      this.kycStatusUpdateRequestDto,
      this.transactionProfileId,
      this.transactionProfileName,
      this.feeProfileId,
      this.feeProfileName,
      this.qrCodeString,
      this.surveyName,
      this.surveyNote,
      });

  UserProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    type = json['type'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    kycLevel = json['kycLevel'];
    status = json['status'];
    nationalId = json['nationalId'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    city = json['city'];
    cityId = json['cityId'];
    state = json['state'];
    profilePictureUrl = json['profilePictureUrl'];
    stateId = json['stateId'];
    zipCode = json['zipCode'];
    country = json['country'];
    countryId = json['countryId'];
    userKycDocuments = json['userKycDocuments'];
    idpId = json['idpId'];
    customerTableId = json['customerTableId'];
    kycInfoId = json['kycInfoId'];
    activeKycInfoId = json['activeKycInfoId'];
    kycStatusUpdateRequestDto = json['kycStatusUpdateRequestDto'];
    transactionProfileId = json['transactionProfileId'];
    transactionProfileName = json['transactionProfileName'];
    feeProfileId = json['feeProfileId'];
    feeProfileName = json['feeProfileName'];
    qrCodeString = json['qrCodeString'];
    surveyName = json['survey_name'];
    surveyNote = json['survey_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['emailVerified'] = emailVerified;
    data['type'] = type;
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['kycLevel'] = kycLevel;
    data['status'] = status;
    data['nationalId'] = nationalId;
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['city'] = city;
    data['cityId'] = cityId;
    data['state'] = state;
    data['profilePictureUrl'] = profilePictureUrl;
    data['stateId'] = stateId;
    data['zipCode'] = zipCode;
    data['country'] = country;
    data['countryId'] = countryId;
    data['userKycDocuments'] = userKycDocuments;
    data['idpId'] = idpId;
    data['customerTableId'] = customerTableId;
    data['kycInfoId'] = kycInfoId;
    data['activeKycInfoId'] = activeKycInfoId;
    data['kycStatusUpdateRequestDto'] = kycStatusUpdateRequestDto;
    data['transactionProfileId'] = transactionProfileId;
    data['transactionProfileName'] = transactionProfileName;
    data['feeProfileId'] = feeProfileId;
    data['feeProfileName'] = feeProfileName;
    data['qrCodeString'] = qrCodeString;
    data['survey_name'] = surveyName;
    data['survey_note'] = surveyNote;
    return data;
  }

  Map<String, dynamic> toAddUserJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cityId'] = cityId;
    data['city'] = city;
    data['country'] = country;
    data['countryId'] = countryId;
    data['countryCode'] = "+1868";
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['nationalId'] = nationalId;
    data['phoneNumber'] = phoneNumber;
    data['state'] = state;
    data['stateId'] = stateId;
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['zipCode'] = zipCode;
    data['idpId'] = idpId;
    data['customerTableId'] = customerTableId;
    data['survey_name'] = surveyName;
    data['survey_note'] = surveyNote;
    if (userKycDocuments != null && nationalId != "") {
      data['userKycDocuments'] =
          userKycDocuments!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  UserProfileResponse.responseWithError(
      String message, DioErrorType? errorType) {
    isSuccess = false;
    msg = message;
    errorType = errorType;
  }

  getDisplayName({String? title}) {
    String _name = "";
    firstName ??= "";
    lastName ??= "";

    _name = "$firstName $lastName";

    return _name.trim().isEmpty
        ? title == null
            ? "Folks"
            : "Welcome to Digital Wallet"
        : _name;
  }
}

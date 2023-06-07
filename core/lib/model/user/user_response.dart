import 'package:core/model/bank/bank_info.dart';
import 'package:core/model/city/city.dart';
import 'package:core/model/city/country.dart';
import 'package:core/model/city/states.dart';
import 'package:core/model/base_response.dart';

class UserResponse extends BaseResponse {
  String? additionalPhone;
  String? code;
  BankInfo? bankInfo;
  City? city;
  Country? country;
  String? email;
  String? facebookUrl;
  String? id;
  String? instagramUrl;
  bool? isDeleted;
  bool? isLocked;
  bool? locked;
  String? linkedInUrl;
  String? name;
  String? firstname;
  String? lastname;
  String? nationalId;
  String? password;
  String? phone;
  String? phone2;
  String? primaryAddress;
  String? profilePicUrl;

//  List<Role>? roles;
  String? secondaryAddress;
  States? state;
  String? type;
  String? typeItemCode;
  String? userCode;
  String? username;
  String? zipCode;
  String? typeItemName;
  String? typeItemId;
  String? street1;
  String? street2;
  String? cityName;
  String? cityId;

  UserResponse.fromJsonMap(Map<String, dynamic> map)
      : additionalPhone = map["additionalPhone"],
        city = map['city'] == null ? null : City?.fromJson(map["city"]),
        country =
            map['country'] == null ? null : Country.fromJsonMap(map["country"]),
        email = map["email"],
        facebookUrl = map["facebookUrl"],
        id = map["id"],
        code = map["code"],
        instagramUrl = map["instagramUrl"],
        isDeleted = map["isDeleted"],
        isLocked = map["isLocked"],
        locked = map["locked"],
        linkedInUrl = map["linkedInUrl"],
        name = map["name"] ?? "${map["firstName"]} ${map["lastName"]}",
        firstname = map["firstName"],
        lastname = map["lastName"],
        nationalId = map["nationalId"],
        password = map["password"],
        phone = map["phone"] ?? map["phoneNumber1"],
        phone2 = map["phoneNumber2"],
        primaryAddress = map["primaryAddress"],
        profilePicUrl = map["profilePicUrl"],
        secondaryAddress = map["secondaryAddress"],
        state = map['state'] == null ? null : States.fromJson(map["state"]),
        type = map["type"],
        typeItemCode = map["typeItemCode"],
        typeItemName = map["typeItemName"],
        typeItemId = map["typeItemId"],
        userCode = map["userCode"],
        username = map["username"],
        cityName = map["cityName"],
        cityId = map["cityId"],
        zipCode = map["zipCode"],
        bankInfo = map["bankInfo"],
        street1 = map["street1"],
        street2 = map["street2"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['additionalPhone'] = additionalPhone;
    if (city == null) {
      data['city'] = null;
    } else {
      data['city'] = city?.toJson();
    }
    if (country == null) {
      data['country'] = null;
    } else {
      data['country'] = country?.toJson();
    }
    data['email'] = email;
    data['facebookUrl'] = facebookUrl;
    data['id'] = id;
    data['instagramUrl'] = instagramUrl;
    data['isDeleted'] = isDeleted;
    data['isLocked'] = isLocked;
    data['linkedInUrl'] = linkedInUrl;
    data['name'] = name;
    data['firstName'] = firstname;
    data['lastName'] = lastname;
    data['nationalId'] = nationalId;
    data['password'] = password;
    data['phone'] = phone;
    data['phoneNumber2'] = phone2;
    data['primaryAddress'] = primaryAddress;
    data['profilePicUrl'] = profilePicUrl;
    data['secondaryAddress'] = secondaryAddress;
    if (state == null) {
      data['state'] = null;
    } else {
      data['state'] = state?.toJson();
    }
    data['type'] = type;
    data['typeItemCode'] = typeItemCode;
    data['typeItemName'] = typeItemName;
    data['typeItemId'] = typeItemId;
    data['userCode'] = userCode;
    data['username'] = username;
    data['zipCode'] = zipCode;
    data['bankInfo'] = bankInfo;
    data['street1'] = street1;
    data['street2'] = street2;
    data['cityName'] = cityName;
    data['cityId'] = cityId;
    return data;
  }

  UserResponse.withError()
      : additionalPhone = null,
        city = null,
        country = null,
        email = null,
        facebookUrl = null,
        id = null,
        instagramUrl = null,
        isDeleted = null,
        isLocked = null,
        locked = null,
        typeItemName = null,
        typeItemId = null,
        linkedInUrl = null,
        name = null,
        firstname = null,
        lastname = null,
        nationalId = null,
        password = null,
        phone = null,
        phone2 = null,
        primaryAddress = null,
        profilePicUrl = null,
        //  roles = [],
        secondaryAddress = null,
        state = null,
        type = null,
        typeItemCode = null,
        userCode = null,
        username = null,
        street1 = null,
        street2 = null,
        cityName = null,
        cityId = null,
        zipCode = null {
    // TODO: implement withError
/*
    bool isDriver() {
      List<Role> filteredRole = roles
          .where((element) =>
      element.type.toLowerCase() == "FLEET_CUSTOMER".toLowerCase() &&
          element.name.toLowerCase() == "Driver".toLowerCase())
          .toList();
      return filteredRole.length > 0;
    }

 bool isFleetAdmin() {
    List<Role> filteredRole = roles
        .where((element) =>
    element.type.toLowerCase() == "FLEET_CUSTOMER".toLowerCase() &&
        element.name.toLowerCase() == "Company Admin".toLowerCase())
        .toList();
    return filteredRole.length > 0;
  }

  bool isCPayAdmin() {
    List<Role> filteredRole = roles
        .where((element) =>
    element.type.toLowerCase() == "CP_AUTHORITY".toLowerCase() &&
        (element.name.toLowerCase() == "Network Security".toLowerCase() ||
            element.name.toLowerCase() == "Admin".toLowerCase()))
        .toList();
    return filteredRole.length > 0;
  }

  bool isAdmin() {
    List<Role> filteredRole = roles
        .where((element) =>
    element.type.toLowerCase() == "CP_AUTHORITY".toLowerCase() &&
        (element.name.toLowerCase() == "Network Security".toLowerCase() ||
            element.name.toLowerCase() == "Admin".toLowerCase() ||
            element.name.toLowerCase() == "Finance Admin".toLowerCase()))
        .toList();
    return filteredRole.length > 0;
  }

  bool isFinanceAdmin() {
    List<Role> filteredRole = roles
        .where((element) =>
    element.type.toLowerCase() == "CP_AUTHORITY".toLowerCase() &&
        element.name.toLowerCase() == "Finance Admin".toLowerCase())
        .toList();
    return filteredRole.length > 0;
  }

  bool isMerchantAdmin() {
    List<Role> filteredRole = roles
        .where((element) =>
    element.type.toLowerCase() == "FLEET_MERCHANT".toLowerCase() &&
        element.name.toLowerCase() == "Merchant Admin".toLowerCase())
        .toList();
    return filteredRole.length > 0;
  }

  String getRoleName() {
    String name = "";

    if (roles != null && roles.isNotEmpty) {
      roles.asMap().forEach((index, element) {
        name += element.name;

        if (index != roles.length - 1) {
          name += ", ";
        }
      });
    }

    return name;
  }*/

/*  String getDisplayName(){
    String _name = "";
    if(firstname == null) firstname = "";
    if(lastname == null) lastname = "";

    _name = "${firstname.trim()?.capitalize()} ${lastname.trim().capitalize()}";

    return _name.trim().isEmpty ? "Not Available" : _name;
  }

  bool getLockedStatus(){
    if(isLocked!=null){
      return isLocked;
    } else{
      return locked;
    }
  }*/
  }
}

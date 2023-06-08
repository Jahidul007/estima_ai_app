import 'dart:convert';
import 'package:core/model/auth/data/model/access_token_request_response.dart';
import 'package:core/model/key_info/key_pair_info.dart';
import 'package:core/model/user/user_profile_response.dart';
import 'package:core/network/preference_manager/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PreferenceManagerImpl extends PreferenceManager {
  static const keyToken = "token";
  static const keyCloakToken = "keycloakToken";
  static const keyLoginInTime = "loginInTime";
  static const keyExpireTime = "expireTime";
  static const keyLogin = "loginResponse";
  static const keyRememberMe = "rememberMe";
  static const keyUsername = "username";
  static const keyPassword = "password";
  static const keyEmail = "email";
  static const keyUser = "user";
  static const keyCustomerProfile = "customerProfile";
  static const keyDigitalWallet = "digitalWallet";
  static const keyUniqueId = "uniqueId";
  static const keyFcmId = "fcmId";
  static const keyFcmToken = "fcmToken";
  static const keyFcmTokenResponse = "fcmTokenResponse";
  static const keyMenus = "menus";
  static const keySelectedRole = "selectedRole";
  static const keySelectedMerchantSite = "selectedMerchantSite";
  static const keySubscriptionInfo = "subscriptionInfo";
  static const keyLocalization = "localization";
  static const keyProfileImage = "userProfile";
  static const keyBiometricPermission = "biometricPermission";
  static const keyPinCodePermission = "pinCodePermission";
  static const keyKeyPairInfo = "keyPairInfo";
  static const keyDeviceToken = "keyDeviceToken";

  Future<FlutterSecureStorage> getSharedPref() async {
    WidgetsFlutterBinding.ensureInitialized();
    return const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions:
            IOSOptions(accessibility: KeychainAccessibility.first_unlock));
  }

  @override
  saveToken(String? token) async {
    await getSharedPref().then((FlutterSecureStorage pref) {
      pref.write(key: keyToken, value: token!);
    });
  }

  @override
  Future<String> getToken() async {
    return await getSharedPref().then((FlutterSecureStorage pref) async {
      var token = pref.read(key: keyToken);
      return token.then((value) => value ?? "");
    });
  }

  @override
  saveAccessTokenInfo(AccessTokenRequestResponse response) async {
    await getSharedPref().then((FlutterSecureStorage pref) {
      saveToken(response.jwt);
      pref.write(key: keyCloakToken, value: jsonEncode(response));
    });
  }

  @override
  Future<AccessTokenRequestResponse> getAccessTokenInfo() async {
    return await getSharedPref().then((FlutterSecureStorage pref) async {
      var keycloak = await pref.read(key: keyCloakToken);
      if (keycloak == null) {
        return AccessTokenRequestResponse.responseWithError(
          "Initial value",
        );
      } else {
        return AccessTokenRequestResponse.fromJson(jsonDecode(keycloak));
      }
    });
  }

  @override
  removeLoginInfo() async {
    await getSharedPref().then((FlutterSecureStorage pref) {
      pref.delete(key: keyToken);
      pref.delete(key: keyLogin);
      pref.delete(key: keyCloakToken);
      pref.delete(key: keyUser);
      pref.delete(key: keyCustomerProfile);
      pref.delete(key: keyLoginInTime);
    });
  }

  @override
  saveUserProfileInfo(UserProfileResponse response) async {
    await getSharedPref().then((FlutterSecureStorage pref) {
      pref.write(key: keyCustomerProfile, value: jsonEncode(response));
    });
  }

  @override
  Future<UserProfileResponse> getUserProfileInfo() async {
    return await getSharedPref().then((FlutterSecureStorage pref) async {
      var customerProfileResponse = await pref.read(key: keyCustomerProfile);
      if (customerProfileResponse == null || customerProfileResponse.isEmpty) {
        return UserProfileResponse.responseWithError("Initial value", null);
      } else {
        return UserProfileResponse.fromJson(
            jsonDecode(customerProfileResponse));
      }
    });
  }

  @override
  saveLoginTime() async {
    await getSharedPref().then((FlutterSecureStorage pref) async {
      await pref.write(key: keyLoginInTime, value: DateTime.now().toString());
    });
  }

  @override
  Future<String> getLoginTime() async {
    return getSharedPref().then((FlutterSecureStorage pref) async {
      var loginTime = await pref.read(key: keyLoginInTime);
      return loginTime ?? "";
    });
  }

  @override
  saveExpireTime(String dateTime) async {
    await getSharedPref().then((FlutterSecureStorage pref) async {
      await pref.write(key: keyExpireTime, value: dateTime.toString());
    });
  }

  @override
  Future<String> getExpireTime() async {
    return getSharedPref().then((FlutterSecureStorage pref) async {
      var expireTime = await pref.read(key: keyExpireTime);
      return expireTime ?? "2021-01-01";
    });
  }

  @override
  clearSavedRoleAndMenus() async {
    await getSharedPref().then((FlutterSecureStorage pref) {
      pref.delete(key: keyMenus);
      pref.delete(key: keySelectedRole);
    });
  }

  @override
  saveEmail(String email) async {
    await getSharedPref().then((FlutterSecureStorage pref) async {
      await pref.write(key: keyEmail, value: email);
    });
  }

  @override
  Future<String> getEmail() async {
    return getSharedPref().then((FlutterSecureStorage pref) async {
      var email = await pref.read(key: keyEmail);
      return email ?? "";
    });
  }

  @override
  void saveFcmToken(String fcmToken) async {
    await getSharedPref().then((FlutterSecureStorage pref) async {
      await pref.write(key: keyFcmToken, value: fcmToken);
    });
  }

  @override
  savePassword(String pass) async {
    await getSharedPref().then((FlutterSecureStorage pref) async {
      await pref.write(key: keyPassword, value: pass);
    });
  }

  /* @override
  saveRememberMe(bool rememberMe) async{
    await getSharedPref().then((SharedPreferences pref) {
      pref.setBool(keyRememberMe, rememberMe);
    });
  }*/

  @override
  saveUsername(String username) async {
    await getSharedPref().then((FlutterSecureStorage pref) async {
      await pref.write(key: keyUsername, value: username);
    });
  }

  @override
  Future<String> getPassword() async {
    return getSharedPref().then((FlutterSecureStorage pref) async {
      var password = await pref.read(key: keyPassword);
      return password ?? "";
    });
  }

  @override
  Future<String> getUsername() async {
    return getSharedPref().then((FlutterSecureStorage pref) async {
      var username = await pref.read(key: keyUsername);
      return username ?? "";
    });
  }

/*
  @override
  Future<bool> isRememberMe() async {
    return await getSharedPref().then((FlutterSecureStorage pref) {
      return pref.getBool(keyRememberMe) == true;
    });
  }
*/

  @override
  Future<void> saveLocalization(String localization) async {
    await getSharedPref().then((FlutterSecureStorage pref) async {
      await pref.write(key: keyLocalization, value: localization);
    });
  }

  @override
  Future<String> getLocalization() async {
    return await getSharedPref().then((FlutterSecureStorage pref) async {
      String token = await pref.read(key: keyLocalization) ?? "en";
      return token;
    });
  }

  @override
  removeUsername() async {
    await getSharedPref().then((FlutterSecureStorage pref) async {
      await pref.delete(key: keyUsername);
    });
  }

  @override
  Future<void> saveProfileImage(String? imageUrl) async {
    await getSharedPref().then((FlutterSecureStorage pref) {
      pref.write(key: keyProfileImage, value: imageUrl ?? "");
    });
  }

  @override
  Future<String> getProfileImage() async {
    return await getSharedPref().then((FlutterSecureStorage pref) async {
      String? value = await pref.read(key: keyProfileImage);
      return value ?? "null";
    });
  }

  @override
  Future<void> saveBiometricPermissionInfo(bool isAuthenticate) async {
    await getSharedPref().then((FlutterSecureStorage pref) {
      pref.write(key: keyBiometricPermission, value: jsonEncode(isAuthenticate));
    });
  }

  @override
  Future<bool> getBioMetricPermissionInfo() async {
    return await getSharedPref().then((FlutterSecureStorage pref) async{
      var value = jsonDecode(await pref.read(key: keyBiometricPermission)??"false");
      return value;
    });
  }

  @override
  Future<bool> getPinCodePermissionInfo() async {
    return await getSharedPref().then((FlutterSecureStorage pref) {
     // return pref.getBool(keyPinCodePermission) == true;
      return false;
    });
  }

  @override
  Future<void> savePinCodePermissionInfo(bool isAuthenticate) async {
    await getSharedPref().then((FlutterSecureStorage pref) {
      //pref.setBool(keyPinCodePermission, isAuthenticate);
    });
  }

  @override
  Future<void> removeBiometricPermission() async {
    await getSharedPref().then((FlutterSecureStorage pref) {
      pref.delete(key: keyBiometricPermission);
      pref.delete(key: keyKeyPairInfo);
      pref.delete(key: keyDeviceToken);
    });
  }

  @override
  Future<void> saveKeyPairInformation(KeyPairInfo keyPairInfo) async {
    await getSharedPref().then((FlutterSecureStorage pref) async {
      await pref.write(key: keyKeyPairInfo, value: jsonEncode(keyPairInfo));
    });
  }

  @override
  Future<KeyPairInfo> getKeyPairInformation() async {
    return await getSharedPref().then((FlutterSecureStorage pref) async {
      var keyPairInfoResponse = await pref.read(key: keyKeyPairInfo);
      if (keyPairInfoResponse == null || keyPairInfoResponse.isEmpty) {
        return KeyPairInfo(
            publicKey: null, privateKey: null, privateKeyId: null);
      } else {
        return KeyPairInfo.fromJson(jsonDecode(keyPairInfoResponse));
      }
    });
  }

  @override
  Future<void> saveDeviceToken(String? deviceToken) async {
    await getSharedPref().then((FlutterSecureStorage pref) async {
      await pref.write(key: keyDeviceToken, value: deviceToken ?? "");
    });
  }

  @override
  Future<String> getDeviceToken() async {
    return await getSharedPref().then((FlutterSecureStorage pref) async {
      String token = await pref.read(key: keyDeviceToken) ?? "";
      return token;
    });
  }
}

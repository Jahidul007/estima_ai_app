import 'package:core/model/auth/data/model/access_token_request_response.dart';
import 'package:core/model/key_info/key_pair_info.dart';
import 'package:core/model/user/user_profile_response.dart';

abstract class PreferenceManager {
  saveToken(String? token);

  Future<String> getToken();

  saveAccessTokenInfo(AccessTokenRequestResponse response);

  Future<AccessTokenRequestResponse> getAccessTokenInfo();

  removeLoginInfo();

  saveUserProfileInfo(UserProfileResponse response);

  Future<UserProfileResponse> getUserProfileInfo();

  saveLoginTime();

  Future<String> getLoginTime();

  saveExpireTime(String dateTime);

  Future<String> getExpireTime();

  clearSavedRoleAndMenus();

  saveEmail(String email);

  Future<String> getEmail();

  void saveFcmToken(String fcmToken);

  saveUsername(String username);

  Future<String> getUsername();

  removeUsername();

/*
  saveRememberMe(bool rememberMe);

  Future<bool> isRememberMe();
*/

  savePassword(String pass);

  Future<String> getPassword();

  Future<void> saveLocalization(String localization);

  Future<String> getLocalization();

  Future<void> saveProfileImage(String? imageUrl);

  Future<String> getProfileImage();

  Future<void> saveBiometricPermissionInfo(bool isAuthenticate);

  Future<bool> getBioMetricPermissionInfo();

  Future<void> savePinCodePermissionInfo(bool isAuthenticate);

  Future<bool> getPinCodePermissionInfo();

  Future<void> removeBiometricPermission();

  Future<void> saveKeyPairInformation(KeyPairInfo keyPairInfo);

  Future<KeyPairInfo> getKeyPairInformation();

  Future<void> saveDeviceToken(String? deviceToken);

  Future<String> getDeviceToken();
}

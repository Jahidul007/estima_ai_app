import 'package:core/model/base_response.dart';
import 'package:core/repository/ApiHelper.dart';
import 'package:core/repository/base_repository.dart';
import 'package:estima_ai_app/app/module/auth/registration/data/model/user_registration_response.dart';

class UseRegistrationRepository extends BaseRepository {
  Future<BaseResponse> submitUserRegistration(
      UserRegistrationResponse userRegistrationResponse) async {
    return callApiAndHandleErrors(
      () async {
        var response = await apiHelper.post(
          "/api/auth/registration",
          userRegistrationResponse.toJson(),
        );
        return BaseResponse.fromJson(response.data)..isSuccess = true;
      },
      (message, errorType) async =>
          BaseResponse(isSuccess: false, msg: message)..errorType = errorType,
    );
  }
}

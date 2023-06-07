import 'package:core/di/setup_core.dart';
import 'package:core/repository/ApiHelper.dart';
import 'package:dio/dio.dart';
import 'package:core/network/dio_provider.dart';

abstract class BaseRepository {
  final apiHelper = ApiBaseHelper(
    getIt.get<String>(instanceName: 'baseUrl'),
    getIt.get<Dio>(instanceName: (httpDio).toString()),
  );
}

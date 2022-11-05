import 'package:dio/dio.dart';
import 'package:simba_courier/core/resourses/strings.dart';
import 'package:simba_courier/core/services/cache.dart';
import 'package:simba_courier/core/services/network.dart';
import 'package:simba_courier/features/login_home/data/models/login_model.dart';

abstract class BaseLoginRemoteDataSource {
  Future<LoginModel> login(String name, String password);
}

class LoginRemoteDataSource extends BaseLoginRemoteDataSource {
  @override
  Future<LoginModel> login(String name, String password) async {
    try {
      final response = await Remote.postData(
          url: AppStrings.login_path,
          data: {'name': name, 'password': password});
      await Cache.setData(key: 'token', value: response.data['token']);
      await Cache.setData(
          key: 'phone', value: response.data['user_profile']['phone']);
      await Cache.setData(
          key: 'userType', value: response.data['user_profile']['name']);
      await Cache.setData(
          key: 'name', value: response.data['user_profile']['customer_name']);
      return LoginModel.fromJson(response.data);
    } on DioError catch (e) {
      throw DioError(
          requestOptions: e.requestOptions,
          error: e.error,
          response: e.response);
    }
  }
}

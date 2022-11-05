import 'package:dio/src/dio_error.dart';
import 'package:dartz/dartz.dart';
import 'package:simba_courier/features/login_home/data/datasources/login_remote_db.dart';
import 'package:simba_courier/features/login_home/domain/repositories/base_login_repo.dart';

import '../models/login_model.dart';

class LoginRepository extends BaseLoginRepository {
  final BaseLoginRemoteDataSource _baseLoginRemoteDataSource;

  LoginRepository(this._baseLoginRemoteDataSource);
  @override
  Future<Either<DioError, LoginModel>> login(
      String name, String password) async {
    try {
      final result = await _baseLoginRemoteDataSource.login(name, password);
      return Right(result);
    } on DioError catch (e) {
      return Left(DioError(
          requestOptions: e.requestOptions,
          error: e.error,
          response: e.response));
    }
  }
}

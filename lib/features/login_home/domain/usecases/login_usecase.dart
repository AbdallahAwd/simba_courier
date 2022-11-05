import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:simba_courier/features/login_home/domain/entities/login_entity.dart';
import 'package:simba_courier/features/login_home/domain/repositories/base_login_repo.dart';

class LoginUsecase {
  final BaseLoginRepository _baseLoginRepository;

  LoginUsecase(this._baseLoginRepository);

  Future<Either<DioError, LoginEntities>> login(
      String name, String password) async {
    return await _baseLoginRepository.login(name, password);
  }
}

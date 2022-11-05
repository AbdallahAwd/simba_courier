import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:simba_courier/features/login_home/domain/entities/login_entity.dart';

abstract class BaseLoginRepository {
  Future<Either<DioError, LoginEntities>> login(String name, String password);
}

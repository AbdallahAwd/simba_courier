import 'package:get_it/get_it.dart';
import 'package:simba_courier/features/home/data/datasources/pickup_datasource.dart';
import 'package:simba_courier/features/home/data/repositories/pickup_repo.dart';
import 'package:simba_courier/features/home/domain/repositories/pickup_repository.dart';
import 'package:simba_courier/features/login_home/data/datasources/login_remote_db.dart';
import 'package:simba_courier/features/login_home/data/repositories/login_repo.dart';
import 'package:simba_courier/features/login_home/domain/repositories/base_login_repo.dart';

final sl = GetIt.instance;

class Locator {
  static void init() {
    //repo
    sl.registerLazySingleton<BaseLoginRepository>(() => LoginRepository(sl()));
    sl.registerLazySingleton<BasePickupRepository>(
        () => PickupRepository(sl()));
    //db
    sl.registerLazySingleton<BaseLoginRemoteDataSource>(
        () => LoginRemoteDataSource());
    sl.registerLazySingleton<BasePickupDataSource>(() => PickupDataSource());
  }
}

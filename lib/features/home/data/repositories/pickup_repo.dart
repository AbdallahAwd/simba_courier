import 'package:simba_courier/features/home/data/datasources/pickup_datasource.dart';
import 'package:simba_courier/features/home/domain/entities/get_pickup.dart';
import 'package:dartz/dartz.dart';
import 'package:simba_courier/features/home/domain/entities/new_pickup.dart';
import 'package:simba_courier/features/home/domain/entities/shipment.dart';
import 'package:simba_courier/features/home/domain/repositories/pickup_repository.dart';

import '../../../../core/error/error.dart';

class PickupRepository implements BasePickupRepository {
  final BasePickupDataSource _basePickupDataSource;

  PickupRepository(this._basePickupDataSource);
  @override
  Future<Either<Failure, List<PickUpEntity>>> getPickUp() async {
    try {
      return Right(await _basePickupDataSource.getPickup());
    } on Failure catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PickUpEntity>>> getPickUpVerified() async {
    try {
      return Right(await _basePickupDataSource.getPickupVerified());
    } on Failure catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ShipmentEntity>>> getPickupShipment(
      String code) async {
    try {
      return Right(await _basePickupDataSource.getPickupShipment(code));
    } on Failure catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, NewPickup>> setNewPickup(
      {required String location,
      required String fleetType,
      required String date}) async {
    try {
      return Right(await _basePickupDataSource.setNewPickup(
          date: date, fleetType: fleetType, location: location));
    } on Failure catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ShipmentEntity>>> getReport(
      String fromDate, String toDate) async {
    try {
      return Right(await _basePickupDataSource.getReport(fromDate, toDate));
    } on Failure catch (e) {
      return Left(Failure(e.message));
    }
  }
}

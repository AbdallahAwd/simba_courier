import 'package:dartz/dartz.dart';
import 'package:simba_courier/features/home/domain/entities/get_pickup.dart';
import 'package:simba_courier/features/home/domain/entities/shipment.dart';

import '../../../../core/error/error.dart';
import '../entities/new_pickup.dart';

abstract class BasePickupRepository {
  Future<Either<Failure, List<PickUpEntity>>> getPickUp();
  Future<Either<Failure, List<PickUpEntity>>> getPickUpVerified();
  Future<Either<Failure, List<ShipmentEntity>>> getPickupShipment(String code);
  Future<Either<Failure, NewPickup>> setNewPickup(
      {required String location,
      required String fleetType,
      required String date});
  Future<Either<Failure, List<ShipmentEntity>>> getReport(
      String fromDate, String toDate);
}

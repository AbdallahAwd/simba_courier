import 'package:dartz/dartz.dart';
import 'package:simba_courier/features/home/domain/entities/get_pickup.dart';
import 'package:simba_courier/features/home/domain/entities/new_pickup.dart';
import 'package:simba_courier/features/home/domain/entities/shipment.dart';
import 'package:simba_courier/features/home/domain/repositories/pickup_repository.dart';

import '../../../../core/error/error.dart';

class PickupUsecases {
  final BasePickupRepository _basePickupRepository;

  PickupUsecases(this._basePickupRepository);

  Future<Either<Failure, List<PickUpEntity>>> getPickup() async {
    return await _basePickupRepository.getPickUp();
  }

  Future<Either<Failure, List<PickUpEntity>>> getPickupVerified() async {
    return await _basePickupRepository.getPickUpVerified();
  }

  Future<Either<Failure, List<ShipmentEntity>>> getPickupShipment(
      String code) async {
    return await _basePickupRepository.getPickupShipment(code);
  }

  Future<Either<Failure, List<ShipmentEntity>>> getReport(
      String fromDate, String toDate) async {
    return await _basePickupRepository.getReport(fromDate, toDate);
  }

  Future<Either<Failure, NewPickup>> setNewPickup(
      {required String location,
      required String fleetType,
      required String date}) async {
    return await _basePickupRepository.setNewPickup(
        date: date, fleetType: fleetType, location: location);
  }
}

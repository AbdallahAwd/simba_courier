import 'package:equatable/equatable.dart';

class PickUpEntity extends Equatable {
  final String? customer;
  final String? collectionDate;
  final String? pickupPoint;
  final String? droppingPoint;
  final String? fleetType;
  final String? status;
  final String? pickupCode;
  final String? driver;

  const PickUpEntity(
      {required this.customer,
      required this.collectionDate,
      required this.pickupPoint,
      required this.droppingPoint,
      required this.fleetType,
      required this.status,
      required this.pickupCode,
      required this.driver});

  @override
  List<Object?> get props => [
        collectionDate,
        customer,
        pickupCode,
        fleetType,
        driver,
        droppingPoint,
        pickupPoint,
        status
      ];
}

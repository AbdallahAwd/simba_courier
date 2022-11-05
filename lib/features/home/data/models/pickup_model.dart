import 'package:simba_courier/features/home/domain/entities/get_pickup.dart';

class PickupModel extends PickUpEntity {
  const PickupModel(
      {required super.customer,
      required super.collectionDate,
      required super.pickupPoint,
      required super.droppingPoint,
      required super.fleetType,
      required super.status,
      required super.pickupCode,
      required super.driver});

  factory PickupModel.fromJson(Map<String, dynamic>? json) {
    return PickupModel(
        customer: json?['customer'],
        collectionDate: json?['collection_date'],
        pickupPoint: json?['pickup_point'],
        droppingPoint: json?['dropping_point'],
        fleetType: json?['fleet_type'],
        status: json?['status'],
        pickupCode: json?['pickup_code'],
        driver: json?['name']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer'] = customer;
    data['collection_date'] = collectionDate;
    data['pickup_point'] = pickupPoint;
    data['dropping_point'] = droppingPoint;
    data['fleet_type'] = fleetType;
    data['status'] = status;
    data['pickup_code'] = pickupCode;
    data['name'] = driver;
    return data;
  }
}

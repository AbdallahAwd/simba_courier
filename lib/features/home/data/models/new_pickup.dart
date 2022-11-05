import 'package:simba_courier/features/home/domain/entities/new_pickup.dart';

class NewPickupModel extends NewPickup {
  const NewPickupModel(
      {super.collectionDate,
      super.pickupLocation,
      super.fleetType,
      super.data});
  factory NewPickupModel.fromJson(Map<String, dynamic> json) {
    return NewPickupModel(data: json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection_date'] = collectionDate;
    data['pickup_location'] = pickupLocation;
    data['fleet_type'] = fleetType;
    return data;
  }
}

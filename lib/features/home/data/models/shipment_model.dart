import 'package:simba_courier/features/home/domain/entities/shipment.dart';

class ShipmentModel extends ShipmentEntity {
  const ShipmentModel(
      {required super.id,
      required super.customer,
      required super.waybill,
      required super.shipmentDate,
      required super.sourceRegion,
      required super.pickupReference,
      required super.sourceBranch,
      required super.pickupPoint,
      required super.pickupAddress,
      required super.destinationRegion,
      required super.destination,
      required super.destinationBranch,
      required super.itemDescription,
      required super.quantity,
      required super.weight,
      required super.statusId,
      required super.receivingDate,
      required super.deliveredBy,
      required super.receiverName,
      required super.receivingTime});

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    return ShipmentModel(
      id: json['id'],
      customer: json['customer'],
      waybill: json['waybill'],
      shipmentDate: json['shipment_date'],
      sourceRegion: json['source_region'],
      pickupReference: json['pickup_reference'],
      sourceBranch: json['source_branch'],
      pickupPoint: json['pickup_point'],
      pickupAddress: json['pickup_address'],
      destinationRegion: json['destination_region'],
      destination: json['destination'],
      destinationBranch: json['destination_branch'],
      itemDescription: json['item_description'],
      quantity: json['quantity'],
      weight: json['weight'],
      statusId: json['status_id'],
      receivingDate: json['receiving_date'],
      deliveredBy: json['delivered_by'],
      receiverName: json['receiver_name'],
      receivingTime: json['receiving_time'],
    );
  }
}

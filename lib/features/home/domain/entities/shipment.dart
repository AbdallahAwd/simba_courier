import 'package:equatable/equatable.dart';

class ShipmentEntity extends Equatable {
  final int? id;
  final String? customer;
  final String? waybill;
  final String? shipmentDate;
  final String? sourceRegion;
  final String? pickupReference;
  final String? sourceBranch;
  final String? pickupPoint;
  final String? pickupAddress;
  final String? destinationRegion;
  final String? destination;
  final String? destinationBranch;
  final String? itemDescription;
  final String? quantity;
  final String? weight;
  final String? statusId;
  final String? receivingDate;
  final String? deliveredBy;
  final String? receiverName;
  final String? receivingTime;

  const ShipmentEntity(
      {required this.id,
      required this.customer,
      required this.waybill,
      required this.shipmentDate,
      required this.sourceRegion,
      required this.pickupReference,
      required this.sourceBranch,
      required this.pickupPoint,
      required this.pickupAddress,
      required this.destinationRegion,
      required this.destination,
      required this.destinationBranch,
      required this.itemDescription,
      required this.quantity,
      required this.weight,
      required this.statusId,
      required this.receivingDate,
      required this.deliveredBy,
      required this.receiverName,
      required this.receivingTime});

  @override
  List<Object?> get props => [
        id,
        customer,
        waybill,
        shipmentDate,
        sourceRegion,
        pickupReference,
        sourceBranch,
        pickupPoint,
        pickupAddress,
        destinationRegion,
        destination,
        destinationBranch,
        itemDescription,
        quantity,
        weight,
        statusId,
        receivingDate,
        deliveredBy,
        receiverName,
        receivingTime,
      ];
}

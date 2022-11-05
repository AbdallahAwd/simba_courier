import 'package:equatable/equatable.dart';
import 'package:simba_courier/features/home/domain/entities/shipment.dart';

class PdfModel extends Equatable {
  final String customerName;
  final String phone;
  final String date;
  final List<ShipmentEntity> shipment;

  const PdfModel(
      {required this.customerName,
      required this.phone,
      required this.date,
      required this.shipment});

  @override
  List<Object?> get props => [customerName, phone, date, shipment];
}

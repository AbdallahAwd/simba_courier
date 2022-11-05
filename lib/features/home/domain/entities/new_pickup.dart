import 'package:equatable/equatable.dart';

class NewPickup extends Equatable {
  final String? collectionDate;
  final String? pickupLocation;
  final String? fleetType;
  final String? data;

  const NewPickup(
      {this.data, this.collectionDate, this.pickupLocation, this.fleetType});

  @override
  List<Object?> get props => [collectionDate, pickupLocation, fleetType];
}

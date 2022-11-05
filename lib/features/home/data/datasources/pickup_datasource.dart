import 'dart:convert';

import 'package:simba_courier/core/error/error.dart';
import 'package:simba_courier/core/services/cache.dart';
import 'package:simba_courier/core/services/network.dart';
import 'package:simba_courier/features/home/data/models/new_pickup.dart';
import 'package:simba_courier/features/home/data/models/pickup_model.dart';
import 'package:simba_courier/features/home/data/models/shipment_model.dart';

abstract class BasePickupDataSource {
  Future<List<PickupModel>> getPickup();
  Future<List<PickupModel>> getPickupVerified();
  Future<List<ShipmentModel>> getPickupShipment(String code);
  Future<NewPickupModel> setNewPickup(
      {required String date,
      required String location,
      required String fleetType});
  Future<List<ShipmentModel>> getReport(String fromDate, String toDate);
}

class PickupDataSource implements BasePickupDataSource {
  @override
  Future<List<PickupModel>> getPickup() async {
    var response = await Remote.postData(
        url: '/api/customer/pickups', data: {"status": "Requested"});
    if (Cache.getData(key: 'sync') != null) {
      if (Cache.getData(key: 'sync')) {
        Cache.setData(key: 'req', value: json.encode(response.data['data']));
      }
    }
    if (response.statusCode == 200) {
      List<PickupModel> pickup = List.from(
          (response.data['data'] as List).map((e) => PickupModel.fromJson(e)));
      return pickup;
    }
    throw Failure('Error while getting the data');
  }

  @override
  Future<List<PickupModel>> getPickupVerified() async {
    var response = await Remote.postData(
        url: '/api/customer/pickups', data: {"status": "Verified"});
    if (response.statusCode == 200) {
      if (Cache.getData(key: 'sync') != null) {
        // await FileManager.writePickup(response.data['data']);
        if (Cache.getData(key: 'sync')) {
          Cache.setData(key: 'ver', value: json.encode(response.data['data']));
        }
      }

      List<PickupModel> pickup = List.from(
          (response.data['data'] as List).map((e) => PickupModel.fromJson(e)));
      return pickup;
    }
    throw Failure('Error while getting the data');
  }

  @override
  Future<List<ShipmentModel>> getPickupShipment(String code) async {
    String year = DateTime.now().year.toString();
    String month = DateTime.now().month.toString();
    String day = DateTime.now().day.toString();
    var response = await Remote.postData(
        url: '/api/customer/search/shipment',
        data: {
          "tracking_id": code,
          "tracking_date": "2022-03-01 - $year-$month-$day"
        });
    if (response.statusCode == 200) {
      if (response.data['data'] != null && response.data['data'] is! String) {
        List<ShipmentModel> shipment = List.from((response.data['data'] as List)
            .map((e) => ShipmentModel.fromJson(e)));
        return shipment;
      } else {
        throw Failure('Error There is no ID like that');
      }
    }
    throw Failure('Error while getting the data');
  }

  @override
  Future<NewPickupModel> setNewPickup(
      {required String date,
      required String location,
      required String fleetType}) async {
    NewPickupModel pickupModel = NewPickupModel(
        collectionDate: date, fleetType: fleetType, pickupLocation: location);
    var response = await Remote.postData(
        url: '/api/customer/pickups/new', data: pickupModel.toJson());
    if (response.statusCode == 200) {
      return NewPickupModel.fromJson(response.data);
    }
    throw Failure('Error while getting the data');
  }

  @override
  Future<List<ShipmentModel>> getReport(String fromDate, String toDate) async {
    var response = await Remote.postData(
        url: '/api/customer/report',
        data: {"from_date": fromDate, "to_date": toDate});
    if (response.statusCode == 200) {
      if (response.data is String) {
        throw Failure('No Reports Found');
      }
      List<ShipmentModel> shipment = List.from(
          (response.data as List).map((e) => ShipmentModel.fromJson(e)));
      return shipment;
    }
    throw Failure('Error while getting the data');
  }
}

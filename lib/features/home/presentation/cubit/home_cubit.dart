import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:simba_courier/core/error/error.dart';
import 'package:simba_courier/core/resourses/strings.dart';
import 'package:simba_courier/core/services/locator.dart';
import 'package:simba_courier/features/home/domain/entities/shipment.dart';
import 'package:simba_courier/features/home/domain/usecases/pickup_usecase.dart';

import '../../domain/entities/get_pickup.dart';
import '../pages/account/account.dart';
import '../pages/home/home.dart';
import '../pages/pickup/pickup.dart';
import '../pages/reports/reports.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<String> appTitle = [
    AppStrings.home,
    AppStrings.pickup,
    AppStrings.reports,
    AppStrings.account
  ];
  List<Widget> pages = [
    const Home(),
    const PickUp(),
    const Reports(),
    const Account()
  ];
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
        activeIcon: Icon(Icons.home),
        icon: Icon(
          Icons.home_outlined,
        ),
        label: AppStrings.home),
    BottomNavigationBarItem(
        activeIcon: Icon(Icons.business_center),
        icon: Icon(
          Icons.business_center_outlined,
        ),
        label: AppStrings.pickup),
    BottomNavigationBarItem(
        activeIcon: Icon(Icons.feed),
        icon: Icon(
          Icons.feed_outlined,
        ),
        label: AppStrings.reports),
    BottomNavigationBarItem(
        activeIcon: Icon(Icons.account_circle),
        icon: Icon(
          Icons.account_circle_outlined,
        ),
        label: AppStrings.account),
  ];

  int currentIndex = 0;
  bool isConnected = true;
  late List<dynamic> pick = [];
  Future<bool> hasInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      getPendingPickups();
    } else {
      isConnected = false;

      emit(SubmitLoading());
    }
    return result;
  }

  XFile? pickedImage;
  void addImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    emit(Picked());
  }

  List<PickUpEntity>? reqPickUp = [];
  void getPendingPickups() async {
    emit(PickLoading());
    var res = await PickupUsecases(sl()).getPickup();
    reqPickUp = [];
    res.fold((l) {
      emit(PickError(l));
    }, (r) {
      reqPickUp!.addAll(r);
      getVerifiedPickups();
    });
  }

  List<PickUpEntity>? verPickUp = [];
  void getVerifiedPickups() async {
    var res = await PickupUsecases(sl()).getPickupVerified();
    verPickUp = [];
    res.fold((l) {
      emit(PickError(l));
    }, (r) {
      verPickUp!.addAll(r);
      emit(Picked());
    });
  }

  List<ShipmentEntity>? shipment = [];
  void getPickupShipment(String code) async {
    emit(PickDLoading());
    var res = await PickupUsecases(sl()).getPickupShipment(code);
    shipment = [];
    res.fold((l) {
      emit(PickError(l));
    }, (r) {
      shipment!.addAll(r);

      emit(Picked());
    });
  }

  String? newPickupResponse = '';
  void setNewPickup(
      {required String date,
      required String fleetType,
      required String location}) async {
    emit(SubmitLoading());
    var res = await PickupUsecases(sl())
        .setNewPickup(date: date, fleetType: fleetType, location: location);

    res.fold((l) {
      emit(PickError(l));
    }, (r) {
      newPickupResponse = r.data;

      emit(Submitted());
    });
  }

  List<ShipmentEntity> report = [];
  void getReport({required String fromDate, required String toDate}) async {
    emit(GenerateLoading());
    var res = await PickupUsecases(sl()).getReport(fromDate, toDate);
    report = [];
    res.fold((l) {
      emit(PickError(l));
    }, (r) async {
      report.addAll(r);
      emit(Generated());
    });
  }
}

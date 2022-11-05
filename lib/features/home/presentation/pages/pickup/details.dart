import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simba_courier/core/resourses/color.dart';
import 'package:simba_courier/core/resourses/strings.dart';
import 'package:simba_courier/core/resourses/styles.dart';
import 'package:simba_courier/core/utils/button.dart';
import 'package:simba_courier/features/home/domain/entities/get_pickup.dart';
import 'package:simba_courier/features/home/domain/entities/shipment.dart';
import 'package:simba_courier/features/home/presentation/widgets/def_app_bar.dart';
import 'package:simba_courier/features/home/presentation/widgets/drawer.dart';

class Details extends StatelessWidget {
  final ShipmentEntity shipmentEntity;
  final PickUpEntity pickUpEntity;
  const Details(
      {Key? key, required this.shipmentEntity, required this.pickUpEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarna(context, currentIndex: 1, isArrow: true),
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  const Text(
                    AppStrings.some_id,
                    style: AppStyle.medium,
                  ),
                  InkWell(
                    onLongPress: () {
                      FlutterClipboard.copy(shipmentEntity.waybill!).then(
                          (value) => Fluttertoast.showToast(msg: 'Copied'));
                    },
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        shipmentEntity.waybill!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.medium,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              textRows(
                  text: AppStrings.pick_id_string,
                  value: pickUpEntity.pickupCode!),
              textRows(
                  text: AppStrings.item_string,
                  value: shipmentEntity.itemDescription!),
              textRows(
                  text: AppStrings.weight_string,
                  value: '${shipmentEntity.weight!} KG'),
              textRows(
                  text: AppStrings.quantity, value: shipmentEntity.quantity!),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Expected Delivery",
                style: AppStyle.normal,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                shipmentEntity.receivingDate ?? '',
                style: AppStyle.medium,
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: shipmentEntity.statusId! == 'Delivered'
                                ? AppColors.grey
                                : AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset(AppAssets.vehical),
                      ),
                      Container(
                        width: 5,
                        height: 105,
                        color: AppColors.grey,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: shipmentEntity.statusId! == 'Delivered'
                                ? AppColors.primaryColor
                                : AppColors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset(AppAssets.shipped_hand),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        AppStrings.pickup,
                        style: AppStyle.medium,
                      ),
                      const Text(
                        "DSTV HQ",
                        style: AppStyle.normal,
                      ),
                      Text(
                        shipmentEntity.sourceRegion!,
                        style: AppStyle.smallMid,
                      ),
                      const SizedBox(
                        height: 72,
                      ),
                      const Text(
                        AppStrings.drop_off,
                        style: AppStyle.medium,
                      ),
                      const Text(
                        AppStrings.sale_point,
                        style: AppStyle.normal,
                      ),
                      Text(
                        shipmentEntity.destinationBranch!,
                        style: AppStyle.smallMid,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: <Widget>[
                  const Spacer(),
                  DefButton(
                      text: AppStrings.done,
                      onTap: () {},
                      size: const Size(165, 47))
                ],
              )
            ],
          ),
        );
      }),
      endDrawer: const AppDrawer(),
    );
  }

  Widget textRows({
    required String text,
    required String value,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              style: AppStyle.normal,
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                FlutterClipboard.copy(value)
                    .then((value) => Fluttertoast.showToast(msg: 'Copied'));
              },
              child: SizedBox(
                width: 100,
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.normal,
                ),
              ),
            ),
          ],
        ),
      );
}

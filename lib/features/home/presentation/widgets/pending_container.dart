import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simba_courier/features/home/domain/entities/get_pickup.dart';
import 'package:simba_courier/features/home/domain/entities/shipment.dart';
import '../../../../core/resourses/color.dart';
import '../../../../core/resourses/strings.dart';
import '../../../../core/resourses/styles.dart';
import '../pages/pickup/details.dart';
import '../pages/pickup/v_pickup_detils.dart';

class PendingContainer extends StatefulWidget {
  final PickUpEntity? pickUpEntity;
  final ShipmentEntity? shipment;
  final bool isDetails;
  final bool isConnected;

  const PendingContainer(
      {super.key,
      this.pickUpEntity,
      this.shipment,
      this.isDetails = false,
      this.isConnected = true});

  @override
  State<PendingContainer> createState() => _PendingContainerState();
}

class _PendingContainerState extends State<PendingContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.pickUpEntity?.status! == 'Verified' &&
            !widget.isDetails &&
            widget.isConnected) {
          Navigator.push(
              context,
              PageTransition(
                  child:
                      VPickupDetils(pickupId: widget.pickUpEntity!.pickupCode!),
                  type: PageTransitionType.rightToLeft));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey[200]!)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.isDetails
                      ? widget.shipment!.deliveredBy ?? 'No one'
                      : widget.pickUpEntity?.customer ?? '',
                  style: AppStyle.normal,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      widget.isDetails
                          ? AppStrings.quantity
                          : AppStrings.fleet_type,
                      style: AppStyle.caption,
                    ),
                    Text(
                      widget.isDetails
                          ? widget.shipment!.quantity ?? '0'
                          : widget.pickUpEntity?.fleetType ?? 'van',
                      style: AppStyle.caption,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      widget.isDetails
                          ? AppStrings.waybill
                          : AppStrings.pick_id_string,
                      style: AppStyle.caption,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        widget.isDetails
                            ? widget.shipment!.waybill ?? ''
                            : widget.pickUpEntity?.pickupCode ?? '',
                        style: AppStyle.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.last_update,
                  style: AppStyle.smallMid,
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    widget.isDetails
                        ? widget.shipment!.shipmentDate ?? ''
                        : widget.pickUpEntity!.collectionDate ?? '',
                    style: AppStyle.smallMid,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (widget.pickUpEntity?.status! == 'Verified' &&
                    !widget.isDetails)
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.primaryColor,
                  ),
                if (widget.isDetails)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Details(
                              shipmentEntity: widget.shipment!,
                              pickUpEntity: widget.pickUpEntity!,
                            ),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.primaryColor,
                      ),
                      child: const Text(
                        AppStrings.details,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontFamily.monstAlt,
                        ),
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}

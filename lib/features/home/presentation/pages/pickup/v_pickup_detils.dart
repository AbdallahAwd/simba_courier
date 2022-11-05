import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simba_courier/features/home/presentation/cubit/home_cubit.dart';
import 'package:simba_courier/features/home/presentation/widgets/def_app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/resourses/color.dart';
import '../../../../../core/resourses/strings.dart';
import '../../../../../core/resourses/styles.dart';
import '../../widgets/drawer.dart';
import '../../widgets/pending_container.dart';
import '../../widgets/search_shape.dart';

class VPickupDetils extends StatefulWidget {
  final String pickupId;
  const VPickupDetils({Key? key, required this.pickupId}) : super(key: key);

  @override
  State<VPickupDetils> createState() => _VPickupDetilsState();
}

class _VPickupDetilsState extends State<VPickupDetils> {
  PageController controller = PageController();
  int currentPageIndex = 0;
  @override
  void initState() {
    HomeCubit.get(context).getPickupShipment(widget.pickupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarna(context, customTitle: 'Pickup Shipment', isArrow: true),
      endDrawer: const AppDrawer(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is! PickDLoading) {
            return Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SearchShape(
                    searchHint: AppStrings.search_pickup,
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    currentPageIndex == 0
                        ? AppStrings.delivered
                        : AppStrings.inTransit,
                    style: AppStyle.medium,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Center(
                    child: SmoothPageIndicator(
                        controller: controller,
                        count: 2,
                        effect: const WormEffect(
                            activeDotColor: AppColors.primaryColor),
                        onDotClicked: (index) {
                          controller.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.50,
                    child: PageView(
                      controller: controller,
                      onPageChanged: (value) {
                        setState(() {
                          currentPageIndex = value;
                        });
                      },
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.6,
                          child: Scrollbar(
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    PendingContainer(
                                      pickUpEntity: HomeCubit.get(context)
                                          .verPickUp![index],
                                      shipment: HomeCubit.get(context)
                                          .shipment!
                                          .where((element) =>
                                              element.statusId == 'Delivered')
                                          .toList()[index],
                                      isDetails: true,
                                    ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 10,
                                    ),
                                itemCount: HomeCubit.get(context)
                                    .shipment!
                                    .where((element) =>
                                        element.statusId == 'Delivered')
                                    .toList()
                                    .length),
                          ),
                        ),
                        if (HomeCubit.get(context)
                            .shipment!
                            .where((element) => element.statusId != 'Delivered')
                            .toList()
                            .isNotEmpty)
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 1.6,
                            child: Scrollbar(
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      PendingContainer(
                                        isDetails: true,
                                        shipment: HomeCubit.get(context)
                                            .shipment!
                                            .where((element) =>
                                                element.statusId != 'Delivered')
                                            .toList()[index],
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                                  itemCount: HomeCubit.get(context)
                                      .shipment!
                                      .where((element) =>
                                          element.statusId != 'Delivered')
                                      .toList()
                                      .length),
                            ),
                          ),
                        if (HomeCubit.get(context)
                            .shipment!
                            .where((element) => element.statusId != 'Delivered')
                            .toList()
                            .isEmpty)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.error,
                                size: 80,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('No in Transit here all have Delivered')
                            ],
                          )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

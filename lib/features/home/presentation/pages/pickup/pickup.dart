import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simba_courier/core/resourses/color.dart';
import 'package:simba_courier/core/resourses/strings.dart';
import 'package:simba_courier/core/resourses/styles.dart';
import 'package:simba_courier/core/services/cache.dart';
import 'package:simba_courier/features/home/data/models/pickup_model.dart';
import 'package:simba_courier/features/home/domain/entities/get_pickup.dart';
import 'package:simba_courier/features/home/presentation/cubit/home_cubit.dart';
import 'package:simba_courier/features/home/presentation/widgets/pending_container.dart';
import 'package:simba_courier/features/home/presentation/widgets/search_shape.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PickUp extends StatefulWidget {
  const PickUp({Key? key}) : super(key: key);

  @override
  State<PickUp> createState() => _PickUpState();
}

class _PickUpState extends State<PickUp> {
  int currentPageIndex = 0;
  PageController controller = PageController();
  late bool isConnected;
  List<dynamic> pp = [];
  List<dynamic> requested = [];
  List<PickUpEntity> pickOffline = [];
  List<PickUpEntity> pickOfflineReq = [];
  @override
  void initState() {
    if (!HomeCubit.get(context).isConnected &&
        Cache.getData(key: 'sync') != null) {
      if (Cache.getData(key: 'sync')) {
        pp = json.decode(Cache.getData(key: 'ver') ?? '');
        requested = json.decode(Cache.getData(key: 'req') ?? '');
        pickOffline.addAll(pp.map((e) => PickupModel.fromJson(e)).toList());
        pickOfflineReq
            .addAll(requested.map((e) => PickupModel.fromJson(e)).toList());
      }
    }
    isConnected = HomeCubit.get(context).isConnected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = HomeCubit.get(context);

        if (state is! PickLoading) {
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
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(11.5)),
                        child: SvgPicture.asset(AppAssets.pending)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      currentPageIndex == 0
                          ? AppStrings.pending
                          : AppStrings.verified,
                      style: AppStyle.medium,
                    ),
                  ],
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
                  height: 3,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.6,
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
                              itemBuilder: (context, index) => PendingContainer(
                                    pickUpEntity: isConnected
                                        ? cubit.reqPickUp![index]
                                        : pickOfflineReq[index],
                                    isConnected: isConnected,
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: isConnected
                                  ? cubit.reqPickUp!.length
                                  : pickOfflineReq.length),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.6,
                        child: Scrollbar(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => PendingContainer(
                                    pickUpEntity: isConnected
                                        ? HomeCubit.get(context)
                                            .verPickUp![index]
                                        : pickOffline[index],
                                    isConnected: isConnected,
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: isConnected
                                  ? HomeCubit.get(context).verPickUp!.length
                                  : pickOffline.length),
                        ),
                      ),
                    ],
                  ),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     DefButton(
                //       text:
                //           '${AppStrings.pending3} (${HomeCubit.get(context).pickUp.length})',
                //       color: AppColors.grey,
                //       onTap: () {},
                //       size: const Size(165, 47),
                //     ),
                //     DefButton(
                //       text: AppStrings.picked,
                //       onTap: () {},
                //       size: const Size(165, 47),
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

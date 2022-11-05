import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simba_courier/core/resourses/color.dart';
import 'package:simba_courier/features/home/presentation/cubit/home_cubit.dart';
import 'package:simba_courier/features/home/presentation/pages/pickup/sheet_model.dart';
import 'package:simba_courier/features/home/presentation/widgets/def_app_bar.dart';
import 'package:simba_courier/features/login_home/data/models/login_model.dart';

import '../widgets/drawer.dart';

class HomeLayer extends StatefulWidget {
  final LoginModel? model;
  final locationController = TextEditingController();

  final pickupController = TextEditingController();
  final vehicleController = TextEditingController();
  HomeLayer({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  State<HomeLayer> createState() => _HomeLayerState();
}

class _HomeLayerState extends State<HomeLayer> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: appBarna(context,
              currentIndex: HomeCubit.get(context).currentIndex),
          body: PageView(
            controller: pageController,
            onPageChanged: ((value) {
              setState(() {
                HomeCubit.get(context).currentIndex = value;
              });
            }),
            children: HomeCubit.get(context).pages,
          ),
          endDrawer: AppDrawer(pageController: pageController),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.primaryColor,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            items: HomeCubit.get(context).items,
            currentIndex: HomeCubit.get(context).currentIndex,
            onTap: (int index) {
              setState(() {
                HomeCubit.get(context).currentIndex = index;
                pageController.jumpToPage(index);
              });
            },
          ),
          floatingActionButton: HomeCubit.get(context).currentIndex == 1
              ? Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(18)),
                    child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          HomeCubit.get(context).pickedImage = null;
                          widget.locationController.clear();
                          widget.pickupController.clear();
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: ((context) {
                                return SheetModel(
                                  locationController: widget.locationController,
                                  pickupController: widget.pickupController,
                                  vehicleController: widget.vehicleController,
                                );
                              }));
                        }),
                  ),
                )
              : null,
        );
      },
    );
  }
}

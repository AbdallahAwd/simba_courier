import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simba_courier/features/home/presentation/cubit/home_cubit.dart';

import '../../../../../core/resourses/color.dart';
import '../../../../../core/resourses/strings.dart';
import '../../../../../core/resourses/styles.dart';
import '../../../../../core/utils/button.dart';
import '../../../../login_home/presentation/widgets/refister_form.dart';

class SheetModel extends StatefulWidget {
  final TextEditingController locationController;
  final TextEditingController vehicleController;
  final TextEditingController pickupController;
  const SheetModel(
      {Key? key,
      required this.locationController,
      required this.vehicleController,
      required this.pickupController})
      : super(key: key);

  @override
  State<SheetModel> createState() => _SheetModelState();
}

class _SheetModelState extends State<SheetModel> {
  var items = [
    'Van',
    'Truck',
    'Motor Bike',
    'Other',
  ];
  Map<String, Widget> itemsIcon = {
    'Van': SvgPicture.asset(AppAssets.van, width: 20, height: 20),
    "Truck": const Icon(Icons.fire_truck),
    "Motor Bike": const Icon(Icons.motorcycle),
    "Other": const Icon(Icons.devices_other),
  };
  String dropdownvalue = 'Van';
  bool isOther = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(11.5)),
                      child: const Icon(
                        Icons.business_center_outlined,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    AppStrings.new_pick,
                    style: AppStyle.medium,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              RegisterForm(
                controller: widget.locationController,
                onTap: () {},
                icona: Icons.location_on,
                text: AppStrings.pick_location,
                keyType: TextInputType.text,
                hint: AppStrings.enter_pick_location,
              ),
              const SizedBox(
                height: 24,
              ),
              if (!isOther)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.grey)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Row(
                            children: [
                              itemsIcon[items]!,
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                items,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: FontFamily.monstAlt),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          if (newValue == "Other") {
                            isOther = true;
                          }
                        });
                      },
                    ),
                  ),
                ),
              if (isOther)
                RegisterForm(
                  controller: widget.vehicleController,
                  onTap: () {},
                  icona: Icons.fire_truck,
                  text: AppStrings.vehicle_type,
                  keyType: TextInputType.text,
                  hint: AppStrings.enter_vehicle_type,
                ),
              const SizedBox(
                height: 24,
              ),
              RegisterForm(
                controller: widget.pickupController,
                icona: Icons.date_range,
                onTap: () async {
                  DateTime? chosenTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2017, 9, 7, 17, 30),
                      lastDate: DateTime(DateTime.now().year,
                          DateTime.now().month + 1, DateTime.now().day + 1));
                  widget.pickupController.text =
                      "${chosenTime!.year}-${chosenTime.month}-${chosenTime.day}";
                },
                text: AppStrings.pickup_date,
                keyType: TextInputType.text,
                hint: AppStrings.enter_pickup_date,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                AppStrings.take_photo,
                style: AppStyle.normalAlt,
              ),
              const SizedBox(
                height: 10,
              ),
              HomeCubit.get(context).pickedImage == null
                  ? InkWell(
                      onTap: () {
                        HomeCubit.get(context).addImage();
                      },
                      child: Container(
                          height: 47,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          )),
                    )
                  : Image.file(
                      File(HomeCubit.get(context).pickedImage!.path),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (state is Submitted)
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            size: 50,
                            color: Colors.green,
                          ),
                          Text(
                            AppStrings.submit_mission,
                            maxLines: 2,
                            style: AppStyle.normal,
                          )
                        ],
                      ),
                    ),
                  DefButton(
                    text: AppStrings.submit,
                    isLoading: state is SubmitLoading,
                    onTap: () {
                      HomeCubit.get(context).setNewPickup(
                          date: widget.pickupController.text,
                          fleetType: dropdownvalue,
                          location: widget.locationController.text);
                      Fluttertoast.showToast(
                          msg: HomeCubit.get(context).newPickupResponse!);
                    },
                    size: const Size(165, 47),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

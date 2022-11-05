import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resourses/strings.dart';
import '../../../../core/resourses/styles.dart';
import '../cubit/home_cubit.dart';

AppBar appBarna(
  context, {
  int? currentIndex,
  String? customTitle,
  bool isArrow = false,
}) {
  return AppBar(
    backgroundColor: Colors.grey[50],
    elevation: 0,
    centerTitle: true,
    title: Text(
      currentIndex != null
          ? HomeCubit.get(context).appTitle[currentIndex]
          : customTitle ?? '',
      style: AppStyle.customStyle(
        color: Colors.black,
      ),
    ),
    leading: isArrow
        ? IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ))
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset(AppAssets.africa),
          ),
    actions: [
      Builder(builder: (context) {
        return IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: SvgPicture.asset(
              AppAssets.menu,
            ));
      })
    ],
  );
}

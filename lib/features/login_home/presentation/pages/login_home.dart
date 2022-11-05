import 'package:flutter/material.dart';
import 'package:simba_courier/config/routes.dart';
import 'package:simba_courier/core/resourses/color.dart';
import 'package:simba_courier/core/resourses/media.dart';
import 'package:simba_courier/core/resourses/strings.dart';
import 'package:simba_courier/core/resourses/styles.dart';

import '../../../../core/utils/button.dart';

class LoginHome extends StatelessWidget {
  const LoginHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: context.height / 3,
            ),
            Image.asset(
              AppAssets.logo,
              width: 206,
              height: 186,
            ),
            SizedBox(
              height: context.height / 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: DefButton(
                text: AppStrings.signUp,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.signup,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: DefButton(
                text: AppStrings.login,
                color: Colors.white,
                isBorder: true,
                textColor: AppColors.primaryColor,
                onTap: () {
                  Navigator.pushNamed(context, Routes.initialRoute);
                },
              ),
            ),
            const Text(
              AppStrings.solgan,
              style: AppStyle.small,
            ),
            const Text(
              AppStrings.version,
              style: AppStyle.small,
            )
          ],
        ),
      ),
    );
  }
}

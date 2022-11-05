// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:simba_courier/core/resourses/styles.dart';
import 'package:simba_courier/features/home/presentation/widgets/def_app_bar.dart';
import 'package:simba_courier/features/home/presentation/widgets/drawer.dart';
import 'package:simba_courier/features/login_home/presentation/widgets/refister_form.dart';

import '../../../../core/utils/button.dart';

class TwoFactor extends StatelessWidget {
  var codeController = TextEditingController();
  TwoFactor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarna(
        context,
        customTitle: "2 factor Authentification",
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            const Text(
              "2 Factor Authentification",
              style: AppStyle.medium,
            ),
            const SizedBox(
              height: 20,
            ),
            RegisterForm(
                text: "Enter 6 digit code",
                keyType: TextInputType.number,
                controller: codeController,
                hint: "Enter 6 digit code"),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                DefButton(
                  text: "Confirm",
                  onTap: () {},
                  size: const Size(165, 47),
                ),
              ],
            ),
          ],
        ),
      ),
      endDrawer: const AppDrawer(),
    );
  }
}

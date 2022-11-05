import 'package:flutter/material.dart';

import '../../../../config/routes.dart';
import '../../../../core/resourses/strings.dart';
import '../../../../core/resourses/styles.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          AppStrings.dontHaveAccount,
          style: AppStyle.smallMid,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.signup);
            },
            child: const Text(
              AppStrings.signUp,
              style: AppStyle.smallMid,
            )),
      ],
    );
  }
}

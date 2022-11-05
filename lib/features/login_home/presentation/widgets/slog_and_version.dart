import 'package:flutter/material.dart';

import '../../../../core/resourses/strings.dart';
import '../../../../core/resourses/styles.dart';

class SlogAndVersion extends StatelessWidget {
  const SlogAndVersion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text(
          AppStrings.solgan,
          style: AppStyle.small,
        ),
        Spacer(),
        Text(
          AppStrings.version,
          style: AppStyle.small,
        )
      ],
    );
  }
}

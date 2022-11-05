import 'package:flutter/material.dart';

import '../../../../core/resourses/styles.dart';

class UserType extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final String userType;
  final Color? color;
  final Color? textColor;

  const UserType(
      {Key? key,
      this.borderRadius,
      required this.userType,
      this.color,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: borderRadius ??
              const BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18)),
          border: Border.all(color: Colors.grey[200]!)),
      child: Text(
        userType,
        style: TextStyle(
            fontSize: 16,
            fontFamily: FontFamily.monst,
            fontWeight: FontWeight.bold,
            color: textColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}

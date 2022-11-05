import 'package:flutter/material.dart';

import '../../../../core/resourses/styles.dart';
import '../../../../core/utils/textfied.dart';

class RegisterForm extends StatelessWidget {
  final String text;
  final TextInputType keyType;
  final IconData? icona;
  final TextEditingController controller;
  final String hint;
  final bool? isObscure;
  final VoidCallback? onTap;
  final bool? enable;
  final Widget? suffixWidget;
  const RegisterForm(
      {Key? key,
      required this.text,
      required this.keyType,
      this.icona,
      required this.controller,
      required this.hint,
      this.isObscure,
      this.suffixWidget,
      this.onTap,
      this.enable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: AppStyle.normalAlt,
        ),
        const SizedBox(
          height: 10,
        ),
        DefTextField(
          keyType: keyType,
          isObscure: isObscure ?? false,
          pre: Icon(icona),
          controller: controller,
          suff: suffixWidget,
          labelText: hint,
          enable: enable,
          onTap: onTap,
          validate: (String? value) {
            if (value!.isEmpty) {
              return 'Must not be empty';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

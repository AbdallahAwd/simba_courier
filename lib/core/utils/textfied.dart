import 'package:flutter/material.dart';
import 'package:simba_courier/core/resourses/styles.dart';

class DefTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? pre;
  final String labelText;
  // ignore: prefer_typing_uninitialized_variables
  final validate;
  final ValueChanged<String>? onChange;
  final ValueChanged<String?>? onSave;
  final Widget? suff;
  final bool? isObscure;
  final TextInputType keyType;

  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmit;
  final bool? enable;
  const DefTextField(
      {Key? key,
      required this.controller,
      this.pre,
      required this.labelText,
      this.validate,
      this.onChange,
      this.onSave,
      this.isObscure = false,
      this.onSubmit,
      required this.keyType,
      this.suff,
      this.enable,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyType,
      obscureText: isObscure!,
      controller: controller,
      onChanged: onChange,
      onTap: onTap,
      enabled: enable,
      onSaved: onSave,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        prefixIcon: pre,
        labelStyle: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontFamily: FontFamily.monst,
            fontWeight: FontWeight.w400),
        suffixIcon: suff,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(color: Colors.grey)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(color: Colors.grey)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(color: Colors.grey)),
        labelText: labelText,
      ),
      validator: validate,
    );
  }
}

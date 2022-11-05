import 'package:flutter/material.dart';
import 'package:simba_courier/core/resourses/color.dart';
import 'package:simba_courier/core/resourses/styles.dart';

class DefButton extends StatelessWidget {
  final Color? color;
  final String text;
  final Color? textColor;
  final bool? isBorder;
  final bool? isLoading;
  final VoidCallback onTap;
  final Size? size;
  const DefButton(
      {Key? key,
      this.color,
      this.isBorder = false,
      required this.text,
      this.textColor,
      this.size,
      required this.onTap,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: size ?? const Size(double.infinity, 52),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                side: isBorder!
                    ? const BorderSide(width: 1, color: Colors.grey)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(18))),
        onPressed: onTap,
        child: !isLoading!
            ? Text(
                text,
                style: AppStyle.normal
                    .copyWith(color: textColor, fontWeight: FontWeight.bold),
              )
            : const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(color: AppColors.grey)),
      ),
    );
  }
}

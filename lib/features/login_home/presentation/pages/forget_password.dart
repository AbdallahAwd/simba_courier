import 'package:flutter/material.dart';
import 'package:simba_courier/core/resourses/color.dart';
import 'package:simba_courier/core/resourses/media.dart';
import 'package:simba_courier/core/resourses/strings.dart';
import 'package:simba_courier/core/resourses/styles.dart';
import 'package:simba_courier/core/utils/button.dart';
import 'package:simba_courier/features/login_home/presentation/widgets/refister_form.dart';

class ForgetPassword extends StatelessWidget {
  final controller = TextEditingController();

  ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              AppAssets.logo,
              width: 250,
              height: 250,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                "Enter Your phone Here and you will get an Email with a reset Link ",
                style: TextStyle(
                    color: AppColors.grey,
                    fontFamily: FontFamily.monstAlt,
                    fontSize: 18)),
            SizedBox(
              height: context.height / 20,
            ),
            RegisterForm(
                text: AppStrings.phoneHint2,
                keyType: TextInputType.phone,
                controller: controller,
                icona: Icons.phone,
                hint: AppStrings.phoneHint2),
            SizedBox(
              height: context.height / 40,
            ),
            DefButton(
                text: AppStrings.send,
                onTap: () async {
                  SnackBar snake = const SnackBar(
                    content: Text(
                      "Sent",
                      style: TextStyle(
                          fontFamily: FontFamily.monstAlt, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snake);
                })
          ],
        ),
      )),
    );
  }
}

// void toast({required String msg}) {
//   Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simba_courier/config/routes.dart';
import 'package:simba_courier/core/resourses/media.dart';
import 'package:simba_courier/core/utils/button.dart';
import 'package:simba_courier/features/login_home/presentation/cubit/login_home_cubit.dart';

import '../../../../core/resourses/color.dart';
import '../../../../core/resourses/strings.dart';
import '../../../../core/resourses/styles.dart';
import '../../../../core/utils/textfied.dart';
import '../widgets/slog_and_version.dart';
import '../widgets/user_type.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  int currentIndex = 0;
  var firstController = TextEditingController();
  var secondController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  List<String> userString = [
    AppStrings.client,
    AppStrings.driver,
    AppStrings.agent
  ];
  List<BorderRadiusGeometry> userBorder = [
    const BorderRadius.only(
        topLeft: Radius.circular(18), topRight: Radius.circular(18)),
    const BorderRadius.only(
        topLeft: Radius.circular(0), topRight: Radius.circular(0)),
    const BorderRadius.only(
        bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18))
  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {},
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: context.height / 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.logo,
                        width: 172,
                        height: 154,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(AppStrings.hello,
                      style:
                          AppStyle.big.copyWith(color: AppColors.primaryColor)),
                  const Text(
                    AppStrings.signUpContinu,
                    style: AppStyle.medium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    AppStrings.step1,
                    style: AppStyle.caption,
                  ),
                  SizedBox(
                    height: context.height / 15,
                  ),
                  const Text(
                    AppStrings.whoIsTheUser,
                    style: TextStyle(
                        fontFamily: FontFamily.monstAlt,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: context.height / 7,
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            child: UserType(
                              userType: userString[index],
                              borderRadius: userBorder[index],
                              color: currentIndex == index
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              textColor:
                                  currentIndex == index ? Colors.white : null,
                            ),
                          );
                        },
                        itemCount: userString.length),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      const Text(
                        AppStrings.firstName,
                        style: AppStyle.normalAlt,
                      ),
                      SizedBox(
                        width: context.height / 7.5,
                      ),
                      const Text(
                        AppStrings.lastName,
                        style: AppStyle.normalAlt,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formkey,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: context.width / 6,
                          height: 50,
                          child: DefTextField(
                            controller: firstController,
                            labelText: AppStrings.firstName,
                            keyType: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'First name please';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: context.height / 15,
                        ),
                        SizedBox(
                          width: context.width / 6,
                          height: 50,
                          child: DefTextField(
                            controller: secondController,
                            labelText: AppStrings.lastName,
                            keyType: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'First name please';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.width / 20,
                  ),
                  DefButton(
                      text: AppStrings.next,
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          Navigator.pushNamed(context, Routes.signup_2,
                              arguments: userString[currentIndex]);
                        }
                      }),
                  Row(
                    children: <Widget>[
                      const Text(
                        AppStrings.haveAccount,
                        style: AppStyle.smallMidAlt,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.initialRoute);
                          },
                          child: const Text(AppStrings.login))
                    ],
                  ),
                  const SlogAndVersion()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

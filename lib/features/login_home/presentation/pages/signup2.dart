import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simba_courier/config/routes.dart';
import 'package:simba_courier/core/resourses/media.dart';
import 'package:simba_courier/core/utils/button.dart';
import 'package:simba_courier/features/login_home/presentation/cubit/login_home_cubit.dart';
import 'package:simba_courier/features/login_home/presentation/widgets/slog_and_version.dart';

import '../../../../core/resourses/color.dart';
import '../../../../core/resourses/strings.dart';
import '../../../../core/resourses/styles.dart';
import '../widgets/refister_form.dart';

class Signup2 extends StatefulWidget {
  final String? args;
  const Signup2({Key? key, required this.args}) : super(key: key);

  @override
  State<Signup2> createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {
  var phoneController = TextEditingController();

  var userNameController = TextEditingController();

  var passwordController = TextEditingController();

  var confpasswordController = TextEditingController();

  bool isPassword = true;
  bool isConfirmPassword = true;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {},
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
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
                      height: 10,
                    ),
                    Text(AppStrings.hello,
                        style: AppStyle.big
                            .copyWith(color: AppColors.primaryColor)),
                    const Text(
                      AppStrings.signUpContinu,
                      style: AppStyle.medium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      AppStrings.step2,
                      style: AppStyle.caption,
                    ),
                    SizedBox(
                      height: context.height / 40,
                    ),
                    RegisterForm(
                        controller: phoneController,
                        hint: AppStrings.phoneHint,
                        icona: Icons.phone,
                        keyType: TextInputType.phone,
                        text: AppStrings.phoneHint),
                    RegisterForm(
                        controller: userNameController,
                        hint: AppStrings.userName,
                        icona: Icons.person,
                        keyType: TextInputType.name,
                        text: AppStrings.userName),
                    RegisterForm(
                        controller: passwordController,
                        hint: AppStrings.password,
                        icona: Icons.lock,
                        keyType: TextInputType.visiblePassword,
                        isObscure: isPassword,
                        suffixWidget: IconButton(
                            onPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                            icon: isPassword
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        text: AppStrings.password),
                    RegisterForm(
                        controller: confpasswordController,
                        hint: AppStrings.confirmPassword,
                        icona: Icons.lock,
                        isObscure: isConfirmPassword,
                        suffixWidget: IconButton(
                            onPressed: () {
                              setState(() {
                                isConfirmPassword = !isConfirmPassword;
                              });
                            },
                            icon: isConfirmPassword
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        keyType: TextInputType.visiblePassword,
                        text: AppStrings.confirmPassword),
                    DefButton(
                        text: AppStrings.signUp,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.home_layer, (route) => false,
                                arguments: widget.args);
                          }
                        }),
                    const SlogAndVersion(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

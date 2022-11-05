import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simba_courier/core/resourses/color.dart';
import 'package:simba_courier/core/resourses/media.dart';
import 'package:simba_courier/core/resourses/strings.dart';
import 'package:simba_courier/core/resourses/styles.dart';
import 'package:simba_courier/core/utils/button.dart';
import 'package:simba_courier/features/login_home/presentation/cubit/login_home_cubit.dart';

import '../../../../config/routes.dart';
import '../../../../core/utils/textfied.dart';
import '../widgets/slog_and_version.dart';

class Login extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          SnackBar snackBar = SnackBar(
            content: Text(state.error.message!),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home_layer, (route) => false,
              arguments: state.login);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: context.height / 12,
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
                          style: AppStyle.big
                              .copyWith(color: AppColors.primaryColor)),
                      const Text(
                        AppStrings.logTOContinu,
                        style: AppStyle.medium,
                      ),
                      SizedBox(
                        height: context.height / 15,
                      ),
                      const Text(
                        AppStrings.enterUserHint,
                        style: AppStyle.normal,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DefTextField(
                        keyType: TextInputType.name,
                        pre: const Icon(Icons.account_circle),
                        controller: userNameController,
                        labelText: AppStrings.userName,
                        validate: (String? value) {
                          if (value!.length < 5) {
                            return 'Please, Enter a your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        AppStrings.password,
                        style: AppStyle.normal,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DefTextField(
                          keyType: TextInputType.visiblePassword,
                          pre: const Icon(Icons.lock),
                          controller: passwordController,
                          labelText: AppStrings.enterPassword,
                          validate: (String? value) {
                            if (value!.length < 8) {
                              return 'Try enter a valid password';
                            }

                            return null;
                          },
                          onTap: () {
                            _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          isObscure: LoginCubit.get(context).isPassword,
                          suff: IconButton(
                            onPressed: () {
                              LoginCubit.get(context).changeIcon();
                            },
                            icon: LoginCubit.get(context).isPassword
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.forgetPassword);
                          },
                          child: const Text(AppStrings.forgetPassword)),
                      DefButton(
                          text: AppStrings.login,
                          isLoading: state is Loading,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).login(
                                  userNameController.text,
                                  passwordController.text);
                            }
                          }),
                      // const DontHaveAccount(),
                      const SizedBox(
                        height: 30,
                      ),
                      const SlogAndVersion()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

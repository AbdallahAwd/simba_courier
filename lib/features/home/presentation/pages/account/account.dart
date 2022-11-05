import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simba_courier/core/resourses/strings.dart';
import 'package:simba_courier/core/resourses/styles.dart';
import 'package:simba_courier/core/services/cache.dart';
import 'package:simba_courier/core/utils/button.dart';
import 'package:simba_courier/features/home/presentation/cubit/home_cubit.dart';
import 'package:simba_courier/features/login_home/presentation/widgets/refister_form.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final phoneController = TextEditingController();

  final currentPasswordController = TextEditingController();

  final newPasswordController = TextEditingController();
  @override
  void initState() {
    phoneController.text = Cache.getData(key: 'phone');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/736x/de/59/4e/de594ec09881da3fa66d98384a3c72ff.jpg'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  Cache.getData(key: 'name'),
                  style: AppStyle.mediumAlt,
                ),
                Text(
                  '+255 ${phoneController.text}',
                  style: AppStyle.caption,
                ),
                const SizedBox(
                  height: 24,
                ),
                RegisterForm(
                    text: AppStrings.change_phone,
                    keyType: TextInputType.phone,
                    controller: phoneController,
                    hint: AppStrings.phoneHint2),
                RegisterForm(
                    text: AppStrings.change_password,
                    keyType: TextInputType.visiblePassword,
                    controller: currentPasswordController,
                    isObscure: true,
                    hint: AppStrings.password),
                RegisterForm(
                    text: AppStrings.new_password,
                    keyType: TextInputType.visiblePassword,
                    controller: newPasswordController,
                    isObscure: true,
                    hint: AppStrings.password),
                RegisterForm(
                    text: AppStrings.repeat_new_password,
                    keyType: TextInputType.visiblePassword,
                    controller: newPasswordController,
                    isObscure: true,
                    hint: AppStrings.password),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    DefButton(
                      text: AppStrings.update,
                      onTap: () async {},
                      size: const Size(160, 47),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

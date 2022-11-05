import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simba_courier/config/routes.dart';
import 'package:simba_courier/core/resourses/media.dart';
import 'package:simba_courier/core/resourses/strings.dart';
import 'package:simba_courier/core/resourses/styles.dart';
import 'package:simba_courier/features/home/presentation/cubit/home_cubit.dart';

class AppDrawer extends StatefulWidget {
  final PageController? pageController;
  const AppDrawer({Key? key, this.pageController}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<Widget> leadingTile = [
    const Icon(Icons.account_circle, color: Colors.black),
    const Icon(Icons.notifications_active, color: Colors.black),
    const Icon(Icons.sync, color: Colors.black),
    const Icon(Icons.info, color: Colors.black),
    SvgPicture.asset(AppAssets.terms),
    SvgPicture.asset(AppAssets.privacy),
    SvgPicture.asset(AppAssets.logout),
  ];
  List<String> textTile = [
    AppStrings.myProfile,
    AppStrings.notifications,
    AppStrings.sync,
    AppStrings.support,
    AppStrings.terms,
    AppStrings.privacy,
    AppStrings.logout,
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: const <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(AppAssets.africa),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppStrings.testName,
                    style: AppStyle.normalAlt,
                  ),
                  Text(
                    AppStrings.testPhone,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: FontFamily.monstAlt,
                        color: Colors.grey),
                  ),
                ],
              )),
          SizedBox(
            height: context.height / 1.5,
            child: ListView.builder(
                itemCount: leadingTile.length,
                itemBuilder: (context, index) {
                  return _drawerListTile(
                    icona: leadingTile[index],
                    text: textTile[index],
                    index: index,
                  );
                }),
          )
        ],
      ),
    );
  }

  _drawerListTile({
    required Widget icona,
    required String text,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            HomeCubit.get(context).currentIndex = 3;
            widget.pageController?.jumpToPage(3);
            Navigator.pop(context);
            break;
          case 1:
            Navigator.pop(context);
            break;

          case 2:
            Navigator.pop(context);
            Navigator.pushNamed(context, Routes.offline_sync);
            break;
          case 3:
            Navigator.pop(context);
            Navigator.pushNamed(context, Routes.help_support,
                arguments: "Help & Support");
            break;
          case 4:
            Navigator.pop(context);
            Navigator.pushNamed(context, Routes.terms,
                arguments: "Terms of Service");
            break;
          case 5:
            Navigator.pop(context);
            Navigator.pushNamed(context, Routes.privacy,
                arguments: "Privacy Policy");
            break;
          case 6:
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.initialRoute,
              (route) => true,
            );
            break;
          default:
            Navigator.pop(context);
        }
      },
      child: ListTile(
        leading: icona,
        title: Text(
          text,
          style: AppStyle.normal,
        ),
      ),
    );
  }
}

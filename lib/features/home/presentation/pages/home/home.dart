import 'package:flutter/material.dart';
import 'package:simba_courier/core/resourses/color.dart';
import 'package:simba_courier/core/resourses/media.dart';
import 'package:simba_courier/core/resourses/strings.dart';
import 'package:simba_courier/core/resourses/styles.dart';
import 'package:simba_courier/features/home/presentation/widgets/search_shape.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var items = [
    'Today',
    'Yesterday',
    'This week',
    'This Month',
    'Last Month',
    'Custom',
  ];
  String dropdownvalue = 'Today';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SearchShape(),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    Text(
                      AppStrings.pending,
                      style: AppStyle.normal,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "987",
                      style: AppStyle.caption,
                    )
                  ],
                ),
                Column(
                  children: const <Widget>[
                    Text(
                      AppStrings.complete,
                      style: AppStyle.normal,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "670",
                      style: AppStyle.caption,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: context.height / 10,
            ),
            Stack(
              children: [
                Image.asset(AppAssets.home),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 104,
                    width: 290,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 17),
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(666)),
                        color: AppColors.primaryColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "The Heart of \n perfect \n delivery",
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: FontFamily.monstAlt,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

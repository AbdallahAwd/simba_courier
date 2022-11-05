import 'package:flutter/material.dart';
import 'package:simba_courier/config/routes.dart';

import '../../../../core/resourses/color.dart';
import '../../../../core/resourses/strings.dart';
import '../../../../core/resourses/styles.dart';

class SearchShape extends StatelessWidget {
  final String? searchHint;

  const SearchShape({
    Key? key,
    this.searchHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.search,
        );
      },
      child: Container(
        height: 47,
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey[200]!)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              searchHint ?? AppStrings.search_shipment,
              style: AppStyle.caption,
            ),
            Container(
                height: 47,
                width: 45,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(18)),
                  color: AppColors.primaryColor,
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}

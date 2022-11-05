import 'package:flutter/material.dart';
import 'package:simba_courier/core/resourses/styles.dart';
import 'package:simba_courier/features/home/presentation/widgets/def_app_bar.dart';
import 'package:simba_courier/features/home/presentation/widgets/drawer.dart';

class Terms extends StatelessWidget {
  final String arg;
  const Terms({Key? key, required this.arg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarna(context, customTitle: arg),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              arg,
              style: AppStyle.medium,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Blandit lectus donec ullamcorper nisl convallis ipsum aliquet et sed. Orci, dignissim ut ut eu facilisis eget tincidunt. Eget ullamcorper vulputate at hac nec platea consectetur turpis. At pellentesque vitae tortor, nibh id fusce volutpat. \nDiam sit pulvinar enim dictumst sem fermentum, congue. Sed et egestas viverra condimentum at eget felis. Elit tincidunt molestie sed a. Etiam urna, laoreet in suscipit porta pharetra aenean. Lorem fames mus viverra fames amet, lectus quis pellentesque.",
              style: AppStyle.caption,
            )
          ],
        ),
      ),
      endDrawer: const AppDrawer(),
    );
  }
}

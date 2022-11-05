import 'package:flutter/material.dart';
import 'package:simba_courier/core/resourses/media.dart';
import 'package:simba_courier/core/resourses/styles.dart';
import 'package:simba_courier/features/home/presentation/widgets/def_app_bar.dart';
import 'package:simba_courier/features/home/presentation/widgets/drawer.dart';
import 'package:simba_courier/features/home/presentation/widgets/search_shape.dart';

class HelpSupport extends StatelessWidget {
  final String arg;
  const HelpSupport({Key? key, required this.arg}) : super(key: key);

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
              height: 20,
            ),
            const SearchShape(
              searchHint: "Type Question",
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: context.height - 280,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: const Icon(Icons.arrow_forward_ios),
                      subtitle: const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit?",
                        style: AppStyle.smallMid,
                      ),
                      onTap: () {
                        debugPrint('Message');
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemCount: 10),
            )
          ],
        ),
      ),
      endDrawer: const AppDrawer(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simba_courier/core/resourses/styles.dart';
import 'package:simba_courier/core/services/cache.dart';
import 'package:simba_courier/features/home/presentation/widgets/def_app_bar.dart';
import 'package:simba_courier/features/home/presentation/widgets/drawer.dart';

class OfflineSync extends StatefulWidget {
  const OfflineSync({super.key});

  @override
  State<OfflineSync> createState() => _OfflineSyncState();
}

class _OfflineSyncState extends State<OfflineSync> {
  late bool isTapped;

  late String formattedDate;

  @override
  void initState() {
    isTapped = Cache.getData(key: 'sync') ?? false;
    formattedDate = Cache.getData(key: 'sync_date') ??
        DateFormat('yyyy/MM/dd - kk:mm').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarna(context,
          customTitle: "Offline Synchronization", isArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Offline Synchronization",
              style: AppStyle.medium,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Toggle On/Off",
                  style: AppStyle.normal,
                ),
                Switch.adaptive(
                    value: isTapped,
                    onChanged: (value) {
                      setState(() {
                        isTapped = value;
                        Cache.setData(key: 'sync', value: value);
                        Cache.setData(key: 'sync_date', value: formattedDate);
                      });
                    }),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (Cache.getData(key: 'sync_data') == null)
              Text(
                "Last Sync on: $formattedDate",
                style: AppStyle.smallMid,
              )
          ],
        ),
      ),
      endDrawer: const AppDrawer(),
    );
  }
}

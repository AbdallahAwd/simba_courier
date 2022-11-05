import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simba_courier/bloc_obs.dart';
import 'package:simba_courier/core/services/cache.dart';
import 'package:simba_courier/core/services/network.dart';
import 'app.dart';
import 'core/services/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Remote.init();
  await Cache.init();
  Locator.init();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white12));
  runApp(const MyApp());
}

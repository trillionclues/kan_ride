import 'dart:async';

import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../routing/route_paths.dart';
import '../constants/strings.dart';
import '../routing/app_router.dart';

part 'app_client_config_provider.g.dart';

late AppClientInfo appClientInfo;

@Riverpod(keepAlive: true)
class AppClientConfig extends _$AppClientConfig {
  @override
  Future<void> build() async {
    await initializeData();
  }

  late PackageInfo packageInfo;
  late String userAgent;

  Future<void> initializeData() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await runSetup();
    });
  }

  Future<void> runSetup() async{
    packageInfo = await PackageInfo.fromPlatform();
    Strings.appVersion = packageInfo.version;
    Strings.appId = packageInfo.packageName;
    await initFKUserAgent();
    ref.read(goRouterProvider).goNamed(AppRoute.splash.name);
  }

  Future<void> initFKUserAgent() async {
    await FkUserAgent.init();
    userAgent = FkUserAgent.userAgent??"";
  }
}

class AppClientInfo {
  String baseUrl;
  String devicePlatform;
  String deviceUUId;
  String deviceModel;
  String deviceManufacturer;
  String deviceVersion;

  AppClientInfo({
    this.baseUrl = "",
    this.devicePlatform = "",
    this.deviceUUId = "",
    this.deviceModel = "",
    this.deviceManufacturer = "",
    this.deviceVersion = "",
  });
}

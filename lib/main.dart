import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kan_ride/src/config/app_client_config_provider.dart';
import 'package:kan_ride/src/storage/shared_preferences.dart';
import 'package:kan_ride/src/network/api_constants.dart';
import 'package:kan_ride/src/flavor/environment.dart';
import 'package:kan_ride/src/utils/device_info.dart';
import 'package:kan_ride/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

// turn off the # in the URLs on the web
  usePathUrlStrategy();

// Setup flavor
  EnvironmentConfig.instance.flavor = Flavor.STAGING;

  final sharedPref = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(sharedPref)],
      child:const MaterialApp(home: MyApp(),),
    ),
  );
}

Future<AppClientInfo> getAppClientInfo() async {
  final deviceUUID = await DeviceInformation.getDeviceId();
  final deviceVersion = await DeviceInformation.getDeviceVersion();
  final deviceModel = await DeviceInformation.getDeviceModel();
  final deviceManufacturer = await DeviceInformation.getDeviceManufacturer();
  bool isDev = EnvironmentConfig.instance.flavor == Flavor.STAGING;

  // configure client
  String prodBaseUrl = "https://test.prod-base-url";

  var appClientInfo = AppClientInfo(
    baseUrl: isDev ? ApiConstants.stagingBaseUrl : prodBaseUrl,
    deviceUUId: deviceUUID ?? "",
    deviceModel: deviceModel ?? "",
    deviceManufacturer: deviceManufacturer ?? "",
    deviceVersion: deviceVersion ?? "",
    devicePlatform: DeviceInformation.getPlatform(),
  );
  return appClientInfo;
}

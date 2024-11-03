import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInformation {
  DeviceInformation._();

  static Future<String?> getDeviceId() async {
    String? deviceId;
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id;
    }
    return deviceId;
  }

  static String getPlatform() {
    String platform = "";
    if (Platform.isIOS) {
      platform = "IOS";
    } else if (Platform.isAndroid) {
      platform = "Android";
    }
    return platform;
  }

  static Future<String?> getDeviceModel() async {
    String? deviceModel;
    final deviceInfo = DeviceInfoPlugin();
    if(Platform.isIOS){
      final iosDeviceInfo = await deviceInfo.iosInfo;
      deviceModel = iosDeviceInfo.model;
    }else if(Platform.isAndroid){
      final androidDeviceInfo = await deviceInfo.androidInfo;
      deviceModel = androidDeviceInfo.model;
    }
    return deviceModel;
  }

  static Future<String?> getDeviceManufacturer() async {
    String? deviceManufacturer;
    final deviceInfo = DeviceInfoPlugin();
    if(Platform.isIOS){
      final iosDeviceInfo = await deviceInfo.iosInfo;
      deviceManufacturer = iosDeviceInfo.systemName;
    }else if (Platform.isAndroid){
      final androidDeviceInfo = await deviceInfo.androidInfo;
      deviceManufacturer = androidDeviceInfo.manufacturer;
    }
    return deviceManufacturer;
  }

  static Future<String?> getDeviceVersion() async {
    String? deviceVersion;
    final deviceInfo = DeviceInfoPlugin();
    if(Platform.isIOS){
      final iosDeviceInfo = await deviceInfo.iosInfo;
      deviceVersion = iosDeviceInfo.systemVersion;
    }else if(Platform.isAndroid){
      final androidDeviceInfo = await deviceInfo.androidInfo;
      deviceVersion = androidDeviceInfo.version.baseOS;
    }
    return deviceVersion;
  }

}

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../domain/model/model.dart';

Future<DeviceInfo> getDeviceDetails() async{
  String name="";
  String identifier="";
  String version="";

  DeviceInfoPlugin deviceInfoPlugin= DeviceInfoPlugin();



  try{

    if(defaultTargetPlatform==TargetPlatform.android) {
      var build= await deviceInfoPlugin.androidInfo;
      name = build.brand + " " + build.model;
      identifier = build.id;
      version = build.version.codename;
    }else if(defaultTargetPlatform== TargetPlatform.iOS){
      var build= await deviceInfoPlugin.iosInfo;
      name = build.name + " " + build.model;
      identifier = build.identifierForVendor!;
      version = build.systemVersion;
    }

  }on PlatformException{
    return DeviceInfo(name, identifier, version);

  }
  return DeviceInfo(name, identifier, version);
}
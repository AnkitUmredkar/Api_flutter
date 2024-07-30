import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ApiHelper/skyScrapperApiHelper.dart';
import '../Model/skyScrapperModel.dart';
import 'package:async_wallpaper/async_wallpaper.dart';

class SkyScrapperProvider extends ChangeNotifier {

  SkyScrapperModal? skyScrapperModalModal;
  String search = 'wallpaper hd';

  Future<SkyScrapperModal?> fromMap(String img) async {
    final data = await SkyScrapperApiHelper.apiHelper.fetchApiData(img);
    skyScrapperModalModal = SkyScrapperModal.fromJson(data);
    return skyScrapperModalModal;
  }

  Future<void> setWallpaper(String url,var screen,var context) async {
    String result;
    bool goToHome = false;

    try {
     await AsyncWallpaper.setWallpaper(
        url: url,
        wallpaperLocation: screen,
        goToHome: goToHome,
        errorToastDetails: ToastDetails.error(),
      );
     Fluttertoast.showToast(
       msg: 'Wallpaper Applied',
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 2,
       backgroundColor: Colors.black,
       textColor: Colors.white,
       fontSize: 16,
     );
     Navigator.of(context).pop();

    } on PlatformException {
      Fluttertoast.showToast(
        msg: 'Failed to set Wallpaper',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );
      Navigator.of(context).pop();
    }
  }
}
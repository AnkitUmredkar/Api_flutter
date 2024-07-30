import 'dart:io';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import '../Model/skyScrapperModel.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import '../Provider/skyScrapperProvider.dart';

class WallPaperList extends StatelessWidget {
  SkyScrapperModal? sm;
  int selectedIndex;

  WallPaperList({super.key, required this.sm, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    SkyScrapperProvider skyScrapperProviderTrue =
        Provider.of<SkyScrapperProvider>(context, listen: true);
    SkyScrapperProvider skyScrapperProviderFalse =
        Provider.of<SkyScrapperProvider>(context, listen: false);
    List keyList = List.generate(sm!.hits.length, (index) => GlobalKey());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PageController pageController = PageController(initialPage: selectedIndex);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: sm!.hits.length,
              itemBuilder: (BuildContext context, int index) => Stack(
                children: [
                  RepaintBoundary(
                    key: keyList[index],
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(sm!.hits[index].largeImageURL),
                      )),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(sm!.hits[index].largeImageURL),
                    )),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: width * 0.21,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24),
                              topLeft: Radius.circular(24),
                            ),
                            color: Colors.black54),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //todo--------------------------------> Download Button
                            IconButton(
                                onPressed: () async {
                                  RenderRepaintBoundary boundary =
                                      keyList[index]
                                              .currentContext
                                              .findRenderObject()
                                          as RenderRepaintBoundary;
                                  ui.Image image = await boundary.toImage();
                                  ByteData? byteData = await (image.toByteData(
                                      format: ui.ImageByteFormat.png));
                                  Uint8List img =
                                      byteData!.buffer.asUint8List();
                                  ImageGallerySaver.saveImage(img);
                                  Fluttertoast.showToast(
                                    msg: 'Image Saved To Gallery',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16,
                                  );
                                },
                                icon: Icon(Icons.file_download_outlined,
                                    color: Colors.white, size: width * 0.088)),
                            //todo--------------------------------> Wall Paper Button
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      alignment: Alignment.center,
                                      title: Text(
                                        'Set Wallpaper',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              skyScrapperProviderFalse
                                                  .setWallpaper(
                                                      sm!.hits[index]
                                                          .webformatURL,
                                                      AsyncWallpaper
                                                          .HOME_SCREEN,context);
                                            },
                                            child:
                                                options(width, 'Home Screen'),
                                          ),
                                          GestureDetector(onTap: (){
                                            skyScrapperProviderFalse
                                                .setWallpaper(
                                                sm!.hits[index]
                                                    .webformatURL,
                                                AsyncWallpaper
                                                    .LOCK_SCREEN,context);
                                          },child: options(width, 'Lock Screen')),
                                          GestureDetector(onTap: (){
                                            skyScrapperProviderFalse
                                                .setWallpaper(
                                                sm!.hits[index]
                                                    .webformatURL,
                                                AsyncWallpaper
                                                    .BOTH_SCREENS,context);
                                          },child: options(width, 'Home Screen + Lock Screen'))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.photo_outlined,
                                    color: Colors.white, size: width * 0.088)),
                            //todo--------------------------------> Share Button
                            IconButton(
                                onPressed: () async {
                                  RenderRepaintBoundary boundary =
                                      keyList[index]
                                              .currentContext!
                                              .findRenderObject()
                                          as RenderRepaintBoundary;
                                  ui.Image image = await boundary.toImage();
                                  ByteData? byteData = await image.toByteData(
                                      format: ui.ImageByteFormat.png);
                                  Uint8List img =
                                      byteData!.buffer.asUint8List();
                                  final path =
                                      await getApplicationDocumentsDirectory();
                                  File file = File("${path.path}/img.png");
                                  file.writeAsBytes(img);
                                  ShareExtend.share(file.path, "image");
                                },
                                icon: Icon(Icons.share_outlined,
                                    color: Colors.white, size: width * 0.088)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: width * 0.137,
                  width: width * 0.137,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(23)),
                      color: Colors.black54),
                  child: Icon(Icons.arrow_back,
                      color: Colors.white, size: width * 0.075),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: width * 0.137,
                width: width * 0.137,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(23)),
                    color: Colors.black54),
                child: Icon(Icons.more_vert,
                    color: Colors.white, size: width * 0.075),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container options(double width, String option) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    alignment: Alignment.center,
    width: width,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40), border: Border.all()),
    child: Text(
      option,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: width * 0.045),
    ),
  );
}

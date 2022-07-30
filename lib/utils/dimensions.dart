import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dimensions {
  static const _heightDeviceDesign = 816;
  static const _widthtDeviceDesign = 432;

  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
  //
  static double pageView = screenHeight / (_heightDeviceDesign / 320);
  static double pageViewContainer = screenHeight / (_heightDeviceDesign / 220);
  static double pageViewTextContainer =
      screenHeight / (_heightDeviceDesign / 120);
  //
  static double height10 = screenHeight / (_heightDeviceDesign / 10);
  static double height15 = screenHeight / (_heightDeviceDesign / 15);
  static double height20 = screenHeight / (_heightDeviceDesign / 20);
  static double height35 = screenHeight / (_heightDeviceDesign / 35);
  static double height45 = screenHeight / (_heightDeviceDesign / 45);
  //
  static double width10 = screenWidth / (_widthtDeviceDesign / 10);
  static double width15 = screenWidth / (_widthtDeviceDesign / 15);
  static double width20 = screenWidth / (_widthtDeviceDesign / 20);
  // font size
  static double font16 = screenHeight / (_heightDeviceDesign / 16);
  static double font20 = screenHeight / (_heightDeviceDesign / 20);
  static double font26 = screenHeight / (_heightDeviceDesign / 26);
  //
  static double radius15 = screenHeight / (_heightDeviceDesign / 15);
  static double radius20 = screenHeight / (_heightDeviceDesign / 20);
  static double radius30 = screenHeight / (_heightDeviceDesign / 30);
  // icon size
  static double iconSize24 = screenHeight / (_heightDeviceDesign / 24);
  static double iconSize16 = screenHeight / (_heightDeviceDesign / 16);

  // popular food
  static double popularFoodImgSize = screenHeight / (_heightDeviceDesign / 360);
  static double recommendedFoodImgSize =
      screenHeight / (_heightDeviceDesign / 300);

  //bottom height
  static double bottomHeightBar = screenHeight / (_heightDeviceDesign / 120);

  // expandable text widget
  static double heightExpandableText =
      screenHeight / (_heightDeviceDesign / 180);
}

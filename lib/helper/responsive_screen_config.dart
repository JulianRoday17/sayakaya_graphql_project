import 'package:flutter/material.dart';

class ResponsiveScreenConfig {
  late Size _screenSize;
  static double _screenHeight = 0, _screenWidth = 0;
  static double designHeight = 640, designWidth = 360;
  //_designHeight + _designWidth = Based on design, you can change it based on your own design(pixels)

  void initGetSize(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _screenHeight = _screenSize.height;
    _screenWidth = _screenSize.width;
  }

  double? get height {
    return _screenHeight;
  }

  double? get width {
    return _screenWidth;
  }
}

double getHeightBasedOnPixels(double height) {
  return (height / ResponsiveScreenConfig.designHeight) *
      ResponsiveScreenConfig._screenHeight;
}

double getWidthBasedOnPixels(double width) {
  return (width / ResponsiveScreenConfig.designWidth) *
      ResponsiveScreenConfig._screenWidth;
}

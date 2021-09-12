import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CBase {
  static double deviceHeight = 0.0;
  static double deviceWidth = 0.0;

  // small
  double slargefontSize = 18;
  double stitlefontSize = 14;
  double ssubTitlefontSize = 9;
  double stextfontSize = 9;
  double ssmallTextfontSize = 9;

  // medium
  double mlargefontSize = 19;
  double mtitlefontSize = 15;
  double msubTitlefontSize = 10;
  double mtextfontSize = 10;
  double msmallTextfontSize = 10;

  // large
  double llargefontSize = 20;
  double ltitlefontSize = 17;
  double lsubTitlefontSize = 13;
  double ltextfontSize = 11;
  double lsmallTextfontSize = 10;

  double getFullWidth(BuildContext context) {
    return deviceWidth;
  }

  double getFullHeight(BuildContext context) {
    return deviceHeight;
  }

  setDeviceDimension(double w, double h) {
    deviceHeight = h;
    deviceWidth = w;
  }

  getDeviceDimension() {
    return deviceHeight * deviceWidth;
  }

  double getHugefontSizeByScreen() {
    var size = getDeviceDimension();

    if (size <= 270000.0) {
      return slargefontSize * 2;
    } else if (size <= 350000.0) {
      return mlargefontSize * 2;
    } else {
      return llargefontSize * 2;
    }
  }

  double getLargefontSizeByScreen() {
    var size = getDeviceDimension();

    if (size <= 270000.0) {
      return slargefontSize;
    } else if (size <= 350000.0) {
      return mlargefontSize;
    } else {
      return llargefontSize;
    }
  }

  double getTitlefontSizeByScreen() {
    var size = getDeviceDimension();

    if (size <= 270000.0) {
      return stitlefontSize;
    } else if (size <= 350000.0) {
      return mtitlefontSize;
    } else {
      return ltitlefontSize;
    }
  }

  double getSubTitlefontSizeByScreen() {
    var size = getDeviceDimension();

    if (size <= 270000.0) {
      return ssubTitlefontSize;
    } else if (size <= 350000.0) {
      return msubTitlefontSize;
    } else {
      return lsubTitlefontSize;
    }
  }

  double getTextfontSizeByScreen() {
    var size = getDeviceDimension();

    if (size <= 270000.0) {
      return stextfontSize;
    } else if (size <= 350000.0) {
      return mtextfontSize;
    } else {
      return ltextfontSize;
    }
  }

  double getSmallfontSizeByScreen() {
    var size = getDeviceDimension();

    if (size <= 270000.0) {
      return ssmallTextfontSize;
    } else if (size <= 350000.0) {
      return msmallTextfontSize;
    } else {
      return lsmallTextfontSize;
    }
  }
}

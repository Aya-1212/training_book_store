import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_book_store/core/utils/app_colors.dart';

TextStyle getTitleStyle(
    {Color? color, double? fontSize, FontWeight? fontWeight, }) {
  return TextStyle(
      color: color ?? AppColors.purple,
      fontSize: fontSize ?? 22.sp,
      fontWeight: fontWeight ?? FontWeight.bold
      );
}

TextStyle getBodyStyle(
    {Color? color, double? fontSize, FontWeight? fontWeight}) {
  return TextStyle(
      color: color ?? AppColors.black,
      fontSize: fontSize ?? 18.sp,
      fontWeight: fontWeight ?? FontWeight.w500);
}

TextStyle getSmallStyle(
    {Color? color, double? fontSize, FontWeight? fontWeight}) {
  return TextStyle(
      color: color ?? AppColors.grey,
      fontSize: fontSize ?? 12.sp,
      fontWeight: fontWeight ?? FontWeight.w300);
}

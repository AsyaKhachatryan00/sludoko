import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sludoko/core/config/theme/app_colors.dart';

final class AppTextStyle {
  AppTextStyle._();

  static TextStyle displayLarge = GoogleFonts.rubikSprayPaint(
    fontSize: 40.25.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.0,
    color: AppColors.white,
  );

  static TextStyle displayMedium = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: 32.sp,
    height: 1.5,
    letterSpacing: 0.64,
    color: AppColors.primary,
  );

  static TextStyle displaySmall = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1,
    letterSpacing: 0,
    color: AppColors.white,
  );

  static TextStyle titleMedium = TextStyle(
    fontFamily: 'SfPro',
    fontWeight: FontWeight.w600,
    fontSize: 17.sp,
    height: 22 / 17,
    letterSpacing: -0.41,
    color: AppColors.black,
  );

  static TextStyle labelLarge = TextStyle(
    fontFamily: 'Digitalt',
    fontWeight: FontWeight.w500,
    fontSize: 24.sp,
    height: 1,
    letterSpacing: 0,
    color: AppColors.white,
  );
}

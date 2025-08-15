import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sludoko/core/config/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.data,
    this.onTap,
    this.height,
    this.textColor,
    this.width,
    this.color,
    this.child,
    this.fontWeight,
    this.border,
    this.boxShadow,
  });

  final String? data;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? color;
  final Widget? child;
  final FontWeight? fontWeight;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 327.w,
        alignment: Alignment.center,
        height: height ?? 56.h,
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(100.r),
          border: border,
        ),

        child: data != null
            ? Text(
                data!,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: textColor ?? AppColors.parisM,
                  fontWeight: fontWeight,
                ),
              )
            : child,
      ),
    );
  }
}

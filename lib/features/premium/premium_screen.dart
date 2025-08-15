import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sludoko/core/config/constants/app_assets.dart';
import 'package:sludoko/core/config/theme/app_colors.dart';
import 'package:sludoko/core/widgets/custom_button.dart';
import 'package:sludoko/features/main/controller/main_controller.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.isRegistered<MainController>()
        ? Get.find<MainController>()
        : Get.put(MainController());

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned.fill(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [AppColors.mainBg, AppColors.mainBg],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              blendMode: BlendMode.darken,
              child: Image.asset(AppImages.premium, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 67.h,
            left: 35.w,
            child: InkWell(
              onTap: () => Get.back(),
              child: SvgPicture.asset(AppSvgs.back),
            ),
          ),

          Positioned(
            top: 220.h,
            left: 32.w,
            child: Text(
              'Support for \$0.49',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.white,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 354.h,
            left: 32.w,
            width: 298.w,
            child: Text(
              'Support the project and help us to be even better!',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withValues(alpha: 0.89),
                letterSpacing: 0,
              ),
            ),
          ),

          Positioned(
            bottom: 50.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: CustomButton(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x00D7D7D7).withValues(alpha: 0),
                          offset: Offset(-14, -14),
                          blurRadius: 7,
                          spreadRadius: -12,
                        ),
                      ],
                      color: AppColors.white.withValues(alpha: 0.01),
                      border: Border.all(
                        width: 1,
                        color: AppColors.white.withValues(alpha: 0.1),
                      ),

                      width: 163.w,
                      data: 'Restore',

                      textColor: AppColors.white,
                    ),
                  ),
                ),
                CustomButton(
                  width: 163.w,
                  data: 'Support',
                  onTap: () => controller.setPremium(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

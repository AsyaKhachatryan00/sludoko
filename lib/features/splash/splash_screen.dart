import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sludoko/core/config/constants/app_assets.dart';
import 'package:sludoko/core/config/constants/storage_keys.dart';
import 'package:sludoko/core/config/theme/app_colors.dart';
import 'package:sludoko/core/route/routes.dart';
import 'package:sludoko/core/widgets/custom_button.dart';
import 'package:sludoko/core/widgets/dialog_screen.dart';
import 'package:sludoko/core/widgets/utils/shared_prefs.dart';
import 'package:sludoko/service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  RxBool startAnimations = false.obs;
  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_opacityController)..addListener(updateUi);

    Future.delayed(const Duration(milliseconds: 500), () {
      startAnimations.value = true;
      _opacityController.forward();
    });

    _opacityController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(microseconds: 3000), () async {
          final isNotificationsOn = locator<SharedPrefs>().getBool(
            StorageKeys.isNotificationsOn,
          );
          if (!isNotificationsOn) {
            openNotDialog();
          }
        });
      }
    });
  }

  void updateUi() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _opacityAnimation.removeListener(updateUi);
    _opacityController.dispose();
  }

  void openNotDialog() {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => DialogScreen(
        onTap: (value) => locator<SharedPrefs>().setBool(
          StorageKeys.isNotificationsOn,
          value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.board),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: 1 - _opacityAnimation.value,
              duration: Duration(milliseconds: 500),
              child: Center(
                child: Image.asset(
                  AppImages.splash,
                  fit: BoxFit.cover,
                  width: 159.w,
                  height: 120.h,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _opacityController.value,
              duration: Duration(milliseconds: 1000),
              child: Stack(
                children: [
                  Positioned(
                    left: -40.w,
                    top: -6.h,
                    width: 462.w,
                    height: 750.h,
                    child: Image.asset(AppImages.splashBg, fit: BoxFit.cover),
                  ),
                  Positioned(
                    left: 32.w,
                    top: 65.h,
                    child: Text(
                      'Sludoko'.toUpperCase(),
                      style: Theme.of(
                        context,
                      ).textTheme.displayLarge?.copyWith(),
                    ),
                  ),

                  Positioned(
                    left: 32.h,
                    top: 264.h,
                    child: Image.asset(AppImages.splashText, height: 144.h),
                  ),

                  Positioned(
                    left: 32.w,
                    top: 424.h,
                    child: CustomButton(
                      data: 'Let’s Play',
                      width: 196.w,
                      onTap: () => Get.offAllNamed(RouteLink.main),
                    ),
                  ),
                  Positioned(
                    bottom: 40.h,
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
                              data: 'Terms of Use',
                              width: 163.w,
                              textColor: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
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
                              data: 'Privacy Policy',
                              width: 163.w,
                              border: Border.all(
                                color: AppColors.white.withValues(alpha: 0.1),
                                width: 1,
                              ),
                              color: AppColors.white.withValues(alpha: 0.01),
                              textColor: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

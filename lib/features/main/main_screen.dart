import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sludoko/core/config/constants/app_assets.dart';
import 'package:sludoko/core/config/theme/app_colors.dart';
import 'package:sludoko/core/route/routes.dart';
import 'package:sludoko/core/widgets/custom_button.dart';
import 'package:sludoko/features/home/controller/game_controller.dart';
import 'package:sludoko/features/main/controller/main_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final MainController _controller;
  final Rx<Difficulty> type = Difficulty.easy.obs;

  @override
  void initState() {
    super.initState();

    if (Get.isRegistered<MainController>()) {
      _controller = Get.find<MainController>();
    } else {
      _controller = Get.put(MainController());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.board),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.bg),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 72.w),
              child: Column(
                children: [
                  Image.asset(AppImages.splash, width: 159.w, height: 104.h),
                  SizedBox(height: 64.h),
                  Obx(
                    () => CustomButton(
                      width: 247.w,
                      onTap: _showDifficultySheet,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Difficulty',
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  color: AppColors.mainBg.withValues(
                                    alpha: 0.64,
                                  ),
                                ),
                          ),
                          Text(
                            type.value.name.capitalize!,
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(color: AppColors.mainBg),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.h),
                    child: CustomButton(
                      width: 247.w,
                      color: AppColors.amaranth,
                      onTap: () => Get.toNamed(
                        RouteLink.home,
                        arguments: {'type': type.value, 'continue': false},
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Start Game',
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(color: AppColors.white),
                          ),
                          Icon(Icons.play_arrow, color: AppColors.white),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    width: 247.w,
                    onTap: () => Get.toNamed(
                      RouteLink.home,
                      arguments: {'type': type.value, 'continue': true},
                    ),
                    color: AppColors.camboge,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Continue',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(color: AppColors.white),
                        ),
                        Icon(Icons.pause, color: AppColors.white),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.h),
                    child: CustomButton(
                      width: 247.w,
                      color: AppColors.summerSky,
                      onTap: () => Get.toNamed(RouteLink.rules),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rules',
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(color: AppColors.white),
                          ),
                          SvgPicture.asset(AppSvgs.rules),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    width: 247.w,
                    color: AppColors.blueViolet,
                    onTap: () => Get.toNamed(RouteLink.settings),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Settings',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(color: AppColors.white),
                        ),
                        Icon(Icons.settings, color: AppColors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDifficultySheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              type.value = Difficulty.easy;
              Get.back();
            },
            child: Text(
              "Easy",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.dogerBlue,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              type.value = Difficulty.medium;
              Get.back();
            },
            child: Text(
              "Medium",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.dogerBlue,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              type.value = Difficulty.hard;
              Get.back();
            },
            child: Text(
              "Hard",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.dogerBlue,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Get.back(),
          isDefaultAction: true,
          child: Text(
            "Cancel",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.dogerBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

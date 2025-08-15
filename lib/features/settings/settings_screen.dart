import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:sludoko/core/config/constants/app_assets.dart';
import 'package:sludoko/core/config/theme/app_colors.dart';
import 'package:sludoko/core/route/routes.dart';
import 'package:sludoko/features/main/controller/main_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late MainController _controller;
  RxBool get _isNotsOn => _controller.isNotsOn;
  RxBool get _isPremium => _controller.isPremium;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 34.w),
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: SvgPicture.asset(AppSvgs.back),
                    ),
                  ),
                  Text(
                    'Settings',
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge?.copyWith(fontSize: 24.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            InkWell(
              onTap: () =>
                  _isPremium.value ? null : Get.toNamed(RouteLink.premium),
              child: Container(
                width: 346.w,
                height: 160.h,
                padding: EdgeInsets.only(left: 16.w, right: 30.w),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.bg),
                    fit: BoxFit.cover,
                  ),
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        _isPremium.value
                            ? 'Thanks for\nSupport!'
                            : 'Support our\napp!',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(color: AppColors.mainBg),
                      ),
                    ),
                    Image.asset(AppImages.icon, width: 70.w, height: 68.h),
                  ],
                ),
              ),
            ),
            Obx(
              () => _decoration(
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  onTap: () => _controller.setNots(!_isNotsOn.value),
                  title: Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainBg,
                    ),
                  ),
                  trailing: CupertinoSwitch(
                    value: _isNotsOn.value,
                    onChanged: (value) => _controller.setNots(value),
                  ),
                ),
              ),
            ),
            _decoration(
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                  'Terms of use',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainBg,
                  ),
                ),
                trailing: Icon(Icons.chevron_right, color: AppColors.mainBg),
              ),
            ),
            _decoration(
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Privacy Policy',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainBg,
                  ),
                ),
                trailing: Icon(Icons.chevron_right, color: AppColors.mainBg),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _decoration(Widget child) {
    return Container(
      width: 346.w,
      height: 64.h,
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: child,
    );
  }
}

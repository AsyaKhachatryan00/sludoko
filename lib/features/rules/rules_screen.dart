import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sludoko/core/config/constants/app_assets.dart';
import 'package:sludoko/core/config/theme/app_colors.dart';
import 'package:sludoko/core/widgets/custom_button.dart';
import 'package:sludoko/features/main/controller/main_controller.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.isRegistered<MainController>()
        ? Get.find<MainController>()
        : Get.put(MainController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: EdgeInsets.only(left: 34.w, right: 8.w),
                      child: SvgPicture.asset(AppSvgs.back),
                    ),
                  ),
                  Text(
                    'Rules',
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge?.copyWith(fontSize: 24.sp),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 52.h),
              child: SizedBox(
                height: 500.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.rules.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 36.w,
                                  right: 60.w,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32.w,
                                      height: 32.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 10,
                                          color: AppColors.white,
                                        ),
                                        color: AppColors.white,
                                      ),
                                      child: Image.asset(
                                        AppImages.colors[index],
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        controller.rules[index].text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.white,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (index < controller.rules.length - 1)
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    36.w,
                                    8.h,
                                    60.w,
                                    8.h,
                                  ),
                                  child: SvgPicture.asset(AppSvgs.step),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomButton(data: 'Got It!', onTap: () => Get.back()),
            ),
          ],
        ),
      ),
    );
  }
}

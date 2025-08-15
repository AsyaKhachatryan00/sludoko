import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sludoko/core/config/constants/app_assets.dart';
import 'package:sludoko/features/home/controller/game_controller.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SudokuController>(
      builder: (controller) => Column(
        spacing: 21.w,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 31.w),
            child: Row(
              children: SudokuColor.values.map((pic) {
                if (pic.index % 2 == 0) {
                  return GestureDetector(
                    onTap: () => controller.selectColor(pic),
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: pic.index == 5 ? 31 : 36.w,
                      ),
                      child: Image.asset(
                        AppImages.colors[pic.index],
                        width: 32.w,
                        height: 32.h,
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 70.w),
            child: Row(
              children: SudokuColor.values.map((pic) {
                if (pic.index % 2 != 0) {
                  return GestureDetector(
                    onTap: () => controller.selectColor(pic),
                    child: Padding(
                      padding: EdgeInsets.only(right: 36.w),

                      child: Image.asset(
                        AppImages.colors[pic.index],
                        width: 32.w,
                        height: 32.h,
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sludoko/core/config/theme/app_colors.dart';
import 'package:sludoko/features/home/controller/game_controller.dart';
import 'package:sludoko/features/home/widgets/win_lose_dialog.dart';

class SudokuBoard extends StatelessWidget {
  final SudokuController controller;
  final VoidCallback onNext;
  const SudokuBoard({
    required this.controller,
    required this.onNext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x33054AB7),
            offset: Offset(0, 0),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(index == 0 ? 16.r : 0),
                topRight: Radius.circular(index == 2 ? 16.r : 0),
                bottomLeft: Radius.circular(index == 6 ? 16.r : 0),
                bottomRight: Radius.circular(index == 8 ? 16.r : 0),
              ),
              color: AppColors.white.withValues(alpha: 0.8),
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemCount: 9,
              itemBuilder: (context, col) {
                final pic = controller.puzzle[index][col];
                final isInitial = controller.fixed[index][col];

                return GestureDetector(
                  onTap: () {
                    controller.selectCell(index, col);
                    if (!isInitial && controller.selectedColor.value != null) {
                      controller.setColor(
                        index,
                        col,
                        controller.selectedColor.value!,
                      );

                      if (controller.mistakes.value == 3) {
                        showDialog(
                          barrierDismissible: false,
                          barrierColor: AppColors.black.withValues(alpha: 0.6),
                          context: context,
                          builder: (context) => WinDialog(
                            mistakes: controller.mistakes.value,
                            timeLeft: Duration(
                              seconds: controller.seconds.value,
                            ),
                            onRestart: controller.restartPuzzle,
                            onNext: onNext,
                          ),
                        );
                      }

                      final solution = controller.checkSolution();
                      if (solution) {
                        showDialog(
                          barrierDismissible: false,
                          barrierColor: AppColors.black.withValues(alpha: 0.6),
                          context: context,
                          builder: (context) => WinDialog(
                            mistakes: controller.mistakes.value,
                            timeLeft: Duration(
                              seconds: controller.seconds.value,
                            ),
                            onRestart: controller.restartPuzzle,
                            onNext: onNext,
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          index == 0 && col == 0 ? 16.r : 4.r,
                        ),
                        topRight: Radius.circular(
                          index == 2 && col == 2 ? 16.r : 4.r,
                        ),
                        bottomLeft: Radius.circular(
                          index == 6 && col == 6 ? 16.r : 4.r,
                        ),
                        bottomRight: Radius.circular(
                          index == 8 && col == 8 ? 16.r : 4.r,
                        ),
                      ),
                      color: AppColors.white,
                    ),
                    child: pic != null
                        ? Image.asset(getColorImage(pic), width: 28, height: 28)
                        : SizedBox(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

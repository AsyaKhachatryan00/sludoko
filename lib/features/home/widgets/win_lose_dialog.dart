import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sludoko/core/config/constants/app_assets.dart';
import 'package:sludoko/core/config/theme/app_colors.dart';

class WinDialog extends StatelessWidget {
  final int mistakes;
  final Duration timeLeft;
  final VoidCallback onRestart;
  final VoidCallback onNext;

  const WinDialog({
    super.key,
    required this.mistakes,
    required this.timeLeft,
    required this.onRestart,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Dialog(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 65.2, sigmaY: 65.2),
              child: Container(
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffFFFFFF).withValues(alpha: 0.3),
                      Color(0xff999999).withValues(alpha: 0.4),
                    ],
                  ),
                  borderRadius: BorderRadiusGeometry.circular(16.r),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.38),
                    borderRadius: BorderRadiusGeometry.circular(16.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 25.h),
                      SvgPicture.asset(
                        mistakes == 3 ? AppSvgs.lose : AppSvgs.win,
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(
                          51.w,
                          16.h,
                          51.w,
                          8.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mistakes',
                              style: Theme.of(
                                context,
                              ).textTheme.displaySmall?.copyWith(),
                            ),

                            Text(
                              'Time Left',
                              style: Theme.of(
                                context,
                              ).textTheme.displaySmall?.copyWith(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.only(
                          left: 81.w,
                          right: 64.w,
                          bottom: 20.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              mistakes.toString(),
                              style: Theme.of(
                                context,
                              ).textTheme.displaySmall?.copyWith(),
                            ),
                            Text(
                              _formatTime(timeLeft),
                              style: Theme.of(
                                context,
                              ).textTheme.displaySmall?.copyWith(),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: _circleIconButton(
                              icon: Icons.refresh,
                              color: AppColors.white,
                              iconColor: AppColors.summerSky,
                              onTap: onRestart,
                            ),
                          ),
                          SizedBox(width: 24),
                          _circleIconButton(
                            icon: Icons.play_arrow,
                            color: AppColors.summerSky,
                            iconColor: AppColors.white,
                            onTap: onNext,
                          ),
                        ],
                      ),
                      SizedBox(height: 35.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 205.h,
          child: Container(
            width: 158.w,
            alignment: Alignment.center,
            height: 45.h,
            decoration: BoxDecoration(
              color: mistakes == 3 ? Color(0xff121111) : AppColors.amaranth,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              mistakes == 3 ? 'YOU LOSE' : 'YOU WIN!',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ],
    );
  }

  Widget _circleIconButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color,
      shape: CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(icon, color: iconColor, size: 36),
        ),
      ),
    );
  }

  String _formatTime(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }
}

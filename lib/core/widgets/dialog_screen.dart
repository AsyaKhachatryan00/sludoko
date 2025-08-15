import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sludoko/core/config/theme/app_colors.dart';

class DialogScreen extends StatelessWidget {
  const DialogScreen({required this.onTap, super.key});
  final Function(bool)? onTap;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
      child: CupertinoAlertDialog(
        title: Text(
          '“Sludoko: Color Sudoku Game” Would Like to Send You Notifications',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(),
        ),

        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: false,
            onPressed: () {
              onTap?.call(false);
              Get.back();
            },
            child: Text(
              "Don't allow",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.dogerBlue,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              onTap?.call(true);
              Get.back();
            },
            child: Text(
              "OK",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.dogerBlue),
            ),
          ),
        ],
      ),
    );
  }
}

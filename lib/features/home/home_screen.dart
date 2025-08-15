import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sludoko/core/config/theme/app_colors.dart';
import 'package:sludoko/core/route/routes.dart';
import 'package:sludoko/core/widgets/custom_button.dart';
import 'package:sludoko/features/home/controller/game_controller.dart';
import 'package:sludoko/features/home/widgets/color_piker.dart';
import 'package:sludoko/features/home/widgets/sodoku_board.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.type, required this.canContinue, super.key});
  final Difficulty type;
  final bool canContinue;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final SudokuController _controller;

  @override
  void initState() {
    super.initState();

    if (Get.isRegistered<SudokuController>()) {
      _controller = Get.find<SudokuController>();
    } else {
      _controller = Get.put(SudokuController());
    }

    _loadGame().then((_) {});
  }

  Future<void> _loadGame() async {
    if (widget.canContinue) {
      int? savedSeconds = await _controller.loadGameState();

      if (savedSeconds != null) {
        _startTimer(savedSeconds);
      } else {
        _generatePuzzle();
      }
    } else {
      _generatePuzzle();
    }
  }

  void _generatePuzzle() {
    final type = widget.type;

    _controller.generatePuzzle(
      type == Difficulty.easy
          ? 40
          : type == Difficulty.medium
          ? 36
          : 28,
    );

    _controller.timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) => _controller.seconds.value++,
    );
  }

  void _startTimer(int startFrom) {
    _controller.seconds.value = startFrom;
    _controller.timer?.cancel();

    _controller.timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) => _controller.seconds.value++,
    );
  }

  @override
  void dispose() {
    _controller.timer?.cancel();
    super.dispose();
  }

  String _formatTime(int secs) {
    int m = secs ~/ 60, s = secs % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 16),
                Icon(Icons.timer, color: Colors.white),
                SizedBox(width: 8),
                Obx(
                  () => Text(
                    _formatTime(_controller.seconds.value),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(),
                  ),
                ),
                Spacer(),
                Container(
                  width: 43.w,
                  height: 24.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: AppColors.white,
                  ),
                  child: Obx(
                    () => Text(
                      '${_controller.mistakes.value}/3',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.mainBg,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 12),
            GetBuilder<SudokuController>(
              builder: (controller) => Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: SudokuBoard(
                      controller: controller,
                      onNext: () {
                        controller
                          ..mistakes.value = 0
                          ..seconds.value = 0
                          ..timer?.cancel();

                        _generatePuzzle();
                        Get.back();
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            ColorPicker(),
            SizedBox(height: 18),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    data: "Clear",
                    width: 105.w,
                    color: AppColors.amaranth,
                    textColor: AppColors.white,
                    onTap: _controller.clearCell,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: CustomButton(
                      data: "Pause",
                      width: 105.w,
                      onTap: _controller.saveGameState,
                    ),
                  ),
                  CustomButton(
                    data: "Rules",
                    width: 105.w,
                    color: AppColors.summerSky,
                    textColor: AppColors.white,
                    onTap: () => Get.toNamed(RouteLink.rules),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

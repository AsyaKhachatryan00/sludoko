import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sludoko/core/config/constants/storage_keys.dart';
import 'package:sludoko/core/widgets/utils/shared_prefs.dart';
import 'package:sludoko/models/rules.dart';
import 'package:sludoko/service_locator.dart';

class MainController extends GetxController {
  final storage = locator<SharedPrefs>();

  RxBool isPremium = false.obs;
  RxBool isNotsOn = true.obs;

  final RxList<Rules> rules = <Rules>[].obs;

  @override
  void onInit() {
    super.onInit();

    storage.init().then((onValue) async {
      getPremium();
      isNotsOn.value = getNots();
      rules.value = await _loadRules();
    });

    update();
  }

  void onClear() {
    update();
  }

  void onBackPressed() {
    Get.back();
    onClear();
  }

  void getPremium() {
    isPremium.value = storage.getBool(StorageKeys.isPremium);
  }

  Future<void> setPremium() async {
    isPremium.value = await storage.setBool(StorageKeys.isPremium, true);
    Get.back();
  }

  bool getNots() => storage.getBool(StorageKeys.isNotificationsOn);

  Future<void> setNots(bool value) async {
    await storage.setBool(StorageKeys.isNotificationsOn, value);
    isNotsOn.value = value;
  }

  Future<List<Rules>> _loadRules() async {
    final String jsonStr = await rootBundle.loadString(
      'assets/data/rules.json',
    );
    final List<dynamic> jsonList = json.decode(jsonStr);
    return jsonList.map((json) => Rules.fromJson(json)).toList();
  }
}

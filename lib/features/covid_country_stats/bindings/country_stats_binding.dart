import 'package:get/get.dart';

import 'package:sayakaya_project_test/features/covid_country_stats/controllers/country_stats_controller.dart';

class CovidStatsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CovidStatsController>(() => CovidStatsController());
  }
}

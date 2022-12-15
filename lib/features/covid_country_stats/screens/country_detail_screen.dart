import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sayakaya_project_test/features/covid_country_stats/controllers/country_stats_controller.dart';
import 'package:sayakaya_project_test/helper/responsive_screen_config.dart';
import 'package:sayakaya_project_test/shared/image_resources.dart';
import 'package:sayakaya_project_test/shared/palette.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CountryDetailScreen extends GetView<CovidStatsController> {
  const CountryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.lightGreen,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Palette.lightGreen,
        centerTitle: true,
        title: Text(Get.arguments['name'].toString()),
        titleTextStyle: const TextStyle(
          color: Colors.blueAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Obx(
        () => SafeArea(
          child: Column(
            children: [
              Hero(
                tag: 'flag${Get.arguments['index']}',
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder: const AssetImage(ImageResources.notFoundImage),
                  image: NetworkImage(
                    Get.arguments['flag'],
                  ),
                  height: getHeightBasedOnPixels(160),
                  width: double.infinity,
                ),
              ),
              controller.deathsHistory.length != 3
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20.0),
                            const Text(
                              'Cases Historical Chart',
                              style: TextStyle(fontSize: 22),
                            ),
                            SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(
                                    title: AxisTitle(text: 'Number of cases')),
                                series: <LineSeries<ChartData, String>>[
                                  LineSeries<ChartData, String>(
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: true),
                                      dataSource: <ChartData>[
                                        ChartData('TwoDaysAgo',
                                            controller.casesHistory[2]),
                                        ChartData('Yesterday',
                                            controller.casesHistory[1]),
                                        ChartData('Today',
                                            controller.casesHistory[0]),
                                      ],
                                      xValueMapper: (ChartData sales, _) =>
                                          sales.day,
                                      yValueMapper: (ChartData sales, _) =>
                                          sales.number)
                                ]),
                            const SizedBox(height: 40.0),
                            const Text(
                              'Deaths Historical Chart',
                              style: TextStyle(fontSize: 22),
                            ),
                            SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(
                                    title: AxisTitle(text: 'Number of deaths')),
                                series: <LineSeries<ChartData, String>>[
                                  LineSeries<ChartData, String>(
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: true),
                                      dataSource: <ChartData>[
                                        ChartData('TwoDaysAgo',
                                            controller.deathsHistory[2]),
                                        ChartData('Yesterday',
                                            controller.deathsHistory[1]),
                                        ChartData('Today',
                                            controller.deathsHistory[0]),
                                      ],
                                      xValueMapper: (ChartData sales, _) =>
                                          sales.day,
                                      yValueMapper: (ChartData sales, _) =>
                                          sales.number)
                                ]),
                            const SizedBox(height: 40.0),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.day, this.number);
  final String day;
  final int number;
}

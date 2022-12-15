import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

import 'package:sayakaya_project_test/features/covid_country_stats/controllers/country_stats_controller.dart';
import 'package:sayakaya_project_test/helper/responsive_screen_config.dart';
import 'package:sayakaya_project_test/shared/constants.dart';
import 'package:sayakaya_project_test/shared/image_resources.dart';
import 'package:sayakaya_project_test/shared/palette.dart';

class CountryListScreen extends GetView<CovidStatsController> {
  final ResponsiveScreenConfig _responsiveScreenConfig =
      ResponsiveScreenConfig();
  final numberFormatter = NumberFormat('#,###,000');

  CountryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _responsiveScreenConfig.initGetSize(context);

    return Scaffold(
        backgroundColor: Palette.lightGreen,
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Palette.lightGreen,
                      expandedHeight: getHeightBasedOnPixels(150),
                      floating: true,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                          ImageResources.covidBackgroundImage,
                          fit: BoxFit.cover,
                        ),
                        title: const Text(
                          'Countries',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        centerTitle: true,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(
                              ConstantData.defaultPadding,
                              ConstantData.defaultPadding,
                              ConstantData.defaultPadding,
                              ConstantData.defaultPadding / 2,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  controller.countryData[index].name,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.processChartData(index);
                                    Get.toNamed('/covid-country-detail',
                                        arguments: {
                                          'index': index,
                                          'name': controller
                                              .countryData[index].name,
                                          'flag': controller
                                              .countryData[index].flag,
                                        });
                                  },
                                  child: Card(
                                    color: Palette.lightOrange.withOpacity(0.9),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          ConstantData.defaultPadding),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Hero(
                                                tag: 'flag$index',
                                                child: FadeInImage(
                                                  placeholder: const AssetImage(
                                                      ImageResources
                                                          .notFoundImage),
                                                  image: NetworkImage(
                                                    controller
                                                        .countryData[index]
                                                        .flag,
                                                  ),
                                                  height: 50,
                                                  width: 80,
                                                ),
                                              ),
                                              const SizedBox(height: 10.0),
                                              Text(
                                                controller.countryData[index]
                                                    .continent,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(
                                                ConstantData.defaultPadding),
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20))),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Population: ${numberFormatter.format(controller.countryData[index].population).toString()}'),
                                                Text(
                                                    'Total Cases: ${numberFormatter.format(controller.countryData[index].cases).toString()}'),
                                                Text(
                                                    'Total Deaths: ${numberFormatter.format(controller.countryData[index].deaths).toString()}')
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: controller.counterPage.value,
                      ),
                    ),
                  ],
                ),
        ));
  }
}

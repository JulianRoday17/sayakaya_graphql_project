import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sayakaya_project_test/features/covid_country_stats/bindings/country_stats_binding.dart';
import 'package:sayakaya_project_test/features/covid_country_stats/screens/country_detail_screen.dart';
import 'package:sayakaya_project_test/features/covid_country_stats/screens/country_list_screen.dart';
import 'package:sayakaya_project_test/shared/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primaryColor: Palette.lightGreen),
      getPages: [
        GetPage(
            name: '/covid-country-list',
            page: () => CountryListScreen(),
            binding: CovidStatsBinding()),
        GetPage(
          name: '/covid-country-detail',
          page: () => const CountryDetailScreen(),
        )
      ],
      initialRoute: '/covid-country-list',
      debugShowCheckedModeBanner: false,
    );
  }
}

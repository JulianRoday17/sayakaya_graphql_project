import 'dart:convert';

import 'package:get/get.dart';

import 'package:sayakaya_project_test/features/covid_country_stats/models/country_model.dart';
import 'package:sayakaya_project_test/features/covid_country_stats/services/country_stats_service.dart';
import 'package:sayakaya_project_test/shared/constants.dart';

class CovidStatsController extends GetxController {
  final CountryStatsService _countryStatsService = CountryStatsService();
  final isLoading = false.obs;
  final counterPage = 6.obs;
  List countryData = <CountryModel>[].obs;
  List casesHistory = [].obs;
  List deathsHistory = [].obs;
  var queryDataFinal = ''.obs;

  @override
  void onInit() {
    super.onInit();
    queryDataFinal.value = ConstantData.querySortName;
    fetchData();
  }

  void fetchData() async {
    isLoading.value = true;
    var response =
        await _countryStatsService.fetchCountriesList(queryDataFinal.value);
    countryData =
        countryModelFromJson(json.encode(response.body?['countries']));
    counterPage.value = countryData.length;
    isLoading.value = false;
  }

  void processChartData(int index) async {
    casesHistory.clear();
    deathsHistory.clear();
    //This method still not optimal,manual fetch and merge of 2 queries(very bad method)
    //I dont have enough time to implement multi graphql queries using getConnect
    casesHistory.add(countryData[index].todayCases);
    deathsHistory.add(countryData[index].todayDeaths);

    var response = await _countryStatsService.fetchCountryDetail(
        ConstantData.queryFilterYesterday, countryData[index].name);
    casesHistory.add(response.body?['country']['result']['todayCases']);
    deathsHistory.add(response.body?['country']['result']['todayDeaths']);

    var response2 = await _countryStatsService.fetchCountryDetail(
        ConstantData.queryFilterTwoDaysAgo, countryData[index].name);

    casesHistory.add(response2.body?['country']['result']['todayCases']);
    deathsHistory.add(response2.body?['country']['result']['todayDeaths']);
  }
}

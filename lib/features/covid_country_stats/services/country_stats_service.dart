import 'package:get/get.dart';

import 'package:sayakaya_project_test/shared/constants.dart';

class CountryStatsService extends GetConnect {
  Future<GraphQLResponse<Map>> fetchCountriesList(String queryData) {
    return query<Map>(queryData,
        url: ConstantData.graphql, variables: {"sortBy": "deaths"});
  }

  Future<GraphQLResponse<Map>> fetchCountryDetail(
      String queryData, String cityName) {
    return query<Map>(queryData,
        url: ConstantData.graphql, variables: {"countryName": cityName});
  }
}

// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

List<CountryModel> countryModelFromJson(String str) => List<CountryModel>.from(
    json.decode(str).map((x) => CountryModel.fromJson(x)));

class CountryModel {
  CountryModel({
    this.name,
    this.flag,
    this.continent,
    this.cases,
    this.deaths,
    this.population,
    this.todayCases,
    this.todayDeaths,
  });

  String? name;
  String? flag;
  String? continent;
  int? cases;
  int? deaths;
  int? population;
  int? todayCases;
  int? todayDeaths;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: json['country'] ?? '',
        flag: json['countryInfo']['flag'] ?? '',
        continent: json['continent'] ?? '',
        cases: json['result']['cases'] ?? 0,
        deaths: json['result']['deaths'] ?? 0,
        population: json['result']['population'] ?? 0,
        todayCases: json['result']['todayCases'] ?? 0,
        todayDeaths: json['result']['todayCases'] ?? 0,
      );
}

class ConstantData {
  static const double defaultPadding = 10.0;
  static const String graphql = 'https://covid19-graphql.netlify.app/';

  //This is a bad thing to do,should use dynamic parameter instead static,but I'm in time trouble so I use static query
  static const String queryFilterYesterday = r"""
      query getcountrydetail($countryName: String!){
        country(name: $countryName, filterBy: yesterday) {
          result {
            todayCases
            todayDeaths
          }
        }
      }
      """;
  static const String queryFilterTwoDaysAgo = r"""
      query getcountrydetail($countryName: String!){
        country(name: $countryName, filterBy: twoDaysAgo) {
          result {
            todayCases
            todayDeaths
          }
        }
      }
      """;

  static const String querySortName = r"""
      query getcountrylist{
        countries {
          country
          countryInfo {
            flag
          }
          result {
            population
            cases
            deaths
            todayCases
            todayDeaths
          }
          continent
        }
      }
      """;

  static const String querySortCases = r"""
      query getcountrylist{
        countries (sortBy:cases){
          country
          countryInfo {
            flag
          }
          result {
            population
            cases
            deaths
            todayCases
            todayDeaths
          }
          continent
        }
      }
      """;

  static const String querySortDeaths = r"""
      query getcountrylist{
        countries (sortBy:deaths) {
          country
          countryInfo {
            flag
          }
          result {
            population
            cases
            deaths
            todayCases
            todayDeaths
          }
          continent
        }
      }
      """;
}

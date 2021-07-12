class CountriesModel {
  String? iso2;
  String? name;
  String? flag;
  int? infected;
  int? recovered;
  int? death;
  int? newInfected;
  int? newRecovered;
  int? newDeath;

  CountriesModel(
      {
        this.infected,
      this.recovered,
      this.death,
      this.newInfected,
      this.newRecovered,
      this.newDeath,
      this.name,
      this.iso2,
      this.flag
      });

  factory CountriesModel.fromJson(Map<String, dynamic> json) {
    return CountriesModel(
      infected: json['cases'] as int,
      recovered: json['recovered'] as int,
      death: json['deaths'] as int,
      newInfected: json['todayCases'] as int,
      newRecovered: json['todayRecovered'] as int,
      newDeath: json['todayDeaths'] as int,
      name: json['country'] as String,
      iso2: json['countryInfo']['iso2'],
      flag: json['countryInfo']['flag'],
    );
  }
}

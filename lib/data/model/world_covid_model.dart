class WorldCovidModel{
  int? infected;
  int? recovered;
  int? death;
  int? newInfected;
  int? newRecovered;
  int? newDeath;
  WorldCovidModel(
      {
        this.infected,
        this.recovered,
        this.death,
        this.newInfected,
        this.newRecovered,
        this.newDeath,
      });
  factory WorldCovidModel.fromJson(Map<String, dynamic> json) {
    return WorldCovidModel(
      infected: json['cases'] as int,
      recovered: json['recovered']as int,
      death: json['deaths']as int,
      newInfected: json['todayCases']as int,
      newRecovered: json['todayRecovered']as int,
      newDeath: json['todayDeaths']as int,
    );
  }
}

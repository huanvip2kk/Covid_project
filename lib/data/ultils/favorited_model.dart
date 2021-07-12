

import 'package:covid_19/data/ultils/favorited_database_helper.dart';

class FavoritedModel {
  String? countryName;
  String? flag;
  String? userName;

  FavoritedModel({
    this.userName,
    this.countryName,
    this.flag,
  });

  Map<String, dynamic> toMap() {
    return {
      FavoritedDatabaseHelper.userName: userName,
      FavoritedDatabaseHelper.flag: flag,
      FavoritedDatabaseHelper.favoritedName: countryName,
    };
  }


  factory FavoritedModel.fromMap(Map<String, dynamic> json) => FavoritedModel(
    countryName: json['countryName'],
    flag: json['flag'],
    userName: json['userName'],
  );
}

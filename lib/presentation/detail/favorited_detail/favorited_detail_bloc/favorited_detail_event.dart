part of 'favorited_detail_bloc.dart';

abstract class FavoritedDetailEvent{}
class FavoritedDetailLoadEvent extends FavoritedDetailEvent{
  String countryName;
  FavoritedDetailLoadEvent({required this.countryName});
}
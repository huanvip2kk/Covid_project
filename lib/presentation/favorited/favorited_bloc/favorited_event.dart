part of 'favorited_bloc.dart';

abstract class FavoritedEvent{}
class FavoritedLoadEvent extends FavoritedEvent{
}
class FavoritedOnDeleteButtonPressedEvent extends FavoritedEvent{
  final String countryName;
  FavoritedOnDeleteButtonPressedEvent({required this.countryName});
}
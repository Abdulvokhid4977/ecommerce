part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent extends Equatable {}

class UpdateFavoriteStatusEvent extends FavoriteEvent{
  final ProductElement productElement;
  final bool isFavorite;
UpdateFavoriteStatusEvent(this.productElement, this.isFavorite);
  @override
  List<Object?> get props => [isFavorite, productElement];


}



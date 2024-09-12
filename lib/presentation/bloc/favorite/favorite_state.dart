part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {
  @override
  List<Object> get props => [];
}
class FavoriteLoading extends FavoriteState {
  @override
  List<Object> get props => [];
}
class FavoriteToggledState extends FavoriteState {
  final bool isFavorite;
  final ProductElement productElement;

  FavoriteToggledState(this.isFavorite, this.productElement);

  @override
  List<Object> get props => [isFavorite, productElement];
}



class FavoriteError extends FavoriteState{
  final String message;
  FavoriteError(this.message);
}
part of 'main_bloc.dart';
@immutable
abstract class MainEvent extends Equatable {
}
class FetchDataEvent extends MainEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class UpdateFavoriteEvent extends MainEvent{
  final bool isFavorite;
  final ProductElement productElement;

  UpdateFavoriteEvent(this.isFavorite, this.productElement);
  @override
  // TODO: implement props
  List<Object?> get props =>[isFavorite];


}

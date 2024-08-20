part of 'main_bloc.dart';

@immutable
class MainState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class MainInitial extends MainState {
  @override
  List<Object> get props => [];
}

class MainLoading extends MainState {
  @override
  List<Object> get props => [];
}

class MainLoaded extends MainState {
  final BannerData banners;
  final Product products;
  final ctg.Category category;

   MainLoaded(this.banners, this.products, this.category);

  @override
  List<Object> get props => [banners];
}

class MainError extends MainState {
  final String message;

 MainError(this.message);

  @override
  List<Object> get props => [message];
}

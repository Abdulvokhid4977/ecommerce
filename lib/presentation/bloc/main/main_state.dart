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
  // Adding copyWith method for easier state updates
  MainLoaded copyWith({
    BannerData? banners,
    Product? products,
    ctg.Category? category,
  }) {
    return MainLoaded(
      banners ?? this.banners,
      products ?? this.products,
      category ?? this.category,
    );
  }

  @override
  List<Object> get props => [banners, products, category];
}

class FetchWishlistState extends MainState{
  final Product product;
  final bool hasData;
  FetchWishlistState(this.product, this.hasData);

  FetchWishlistState copyWith({
    bool? hasData,
    Product? product,
  }) {
    return FetchWishlistState(
      product ?? this.product,
      hasData ?? this.hasData,
    );
  }

  @override
  List<Object> get props=>[product];
}

class FavoriteToggledState extends MainState {
  final bool isFavorite;
  final ProductElement productElement;

  FavoriteToggledState(this.isFavorite, this.productElement);

  @override
  List<Object> get props => [isFavorite, productElement];
}

class MainError extends MainState {
  final String message;

 MainError(this.message);

  @override
  List<Object> get props => [message];
}

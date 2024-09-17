part of 'search_bloc.dart';

@immutable
class SearchState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class CategoryLoaded extends SearchState {
  final ctg.Category category;

  CategoryLoaded(this.category);

  // Adding copyWith method for easier state updates
  CategoryLoaded copyWith({
    ctg.Category? category,
  }) {
    return CategoryLoaded(
      category ?? this.category,
    );
  }

  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final ctg.Category category;

  SearchLoaded(this.category);

  // Adding copyWith method for easier state updates
  SearchLoaded copyWith({
    ctg.Category? category,
  }) {
    return SearchLoaded(
      category ?? this.category,
    );
  }

  @override
  List<Object> get props => [category];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchSuccess extends SearchState {
  final Product products;
  final ctg.Category? category;
  final bool isCompleted;

  SearchSuccess(this.products, {this.isCompleted=false,this.category, });

  @override
  List<Object?> get props => [products, category];
}

class FetchCategoryProductLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class FetchCategoryProductState extends SearchState {
  final Product product;
  final bool hasData;

  FetchCategoryProductState(this.product, this.hasData);

  FetchCategoryProductState copyWith({
    Product? product,
    bool? hasData,
  }) {
    return FetchCategoryProductState(
      product ?? this.product,
      hasData ?? this.hasData,
    );
  }

  @override
  List<Object> get props => [product, hasData];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

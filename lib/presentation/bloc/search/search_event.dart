part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {}

class FetchCategoryProductEvent extends SearchEvent {
  final String categoryId;

  FetchCategoryProductEvent(this.categoryId);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {}

class FetchSearchDataEvent extends SearchEvent {
  final String categoryId;
  final bool fromNavBar;

  FetchSearchDataEvent(this.categoryId, this.fromNavBar);

  @override
  // TODO: implement props
  List<Object?> get props => [categoryId, fromNavBar];
}
// class FetchCategoryListEvent extends SearchEvent{
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }


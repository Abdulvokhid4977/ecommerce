part of 'main_bloc.dart';

@immutable
class MainState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
//   final bool isLoading;
//  final BannerData banners;
//
// const HomeState({required this.banners, required this.isLoading});
// HomeState copyWith({BannerData? banners, bool? isLoading}){
//   return HomeState(
//     banners: banners ?? this.banners,
//     isLoading: isLoading ?? this.isLoading,
//
//   );
// }
//   @override
//   // TODO: implement props
//   List<Object?> get props => [banners];
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
  final BannerData banners; // Replace with your data type

   MainLoaded(this.banners);

  @override
  List<Object> get props => [banners];
}

class MainError extends MainState {
  final String message;

 MainError(this.message);

  @override
  List<Object> get props => [message];
}

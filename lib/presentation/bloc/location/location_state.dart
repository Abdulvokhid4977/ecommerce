part of 'location_bloc.dart';


abstract class LocationState extends Equatable{}

class LocationLoading extends LocationState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class LocationFetched extends LocationState{
  final Location location;
  LocationFetched(this.location);

  @override
  // TODO: implement props
  List<Object?> get props => [location];


}
class LocationError extends LocationState{
  final String message;
  LocationError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
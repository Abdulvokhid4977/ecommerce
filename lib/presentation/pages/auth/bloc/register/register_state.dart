part of 'register_bloc.dart';


abstract class RegisterState extends Equatable {}

final class RegisterInitial extends RegisterState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RegisterLoading extends RegisterState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

class RegisterSuccess extends RegisterState{
  RegisterSuccess();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateProfile extends RegisterState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class RegisterError extends RegisterState{
  final String message;
  RegisterError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

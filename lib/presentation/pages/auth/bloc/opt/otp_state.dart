part of 'otp_bloc.dart';

abstract class OtpState extends Equatable {}

class OtpInitial extends OtpState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class OtpLoading extends OtpState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class OtpSuccess extends OtpState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class VerifyLoading extends OtpState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class VerifyUnsuccessful extends OtpState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class VerifySuccess extends OtpState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OtpError extends OtpState{
  final String message;
  OtpError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

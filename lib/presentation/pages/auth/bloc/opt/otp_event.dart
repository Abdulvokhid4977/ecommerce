part of 'otp_bloc.dart';


abstract class OtpEvent extends Equatable{}

class OtpCodeEvent extends OtpEvent{
  final String phoneNumber;
  OtpCodeEvent(this.phoneNumber);
  @override
  // TODO: implement props
  List<Object?> get props => [phoneNumber];
}
class VerifyCodeEvent extends OtpEvent{
  final String phoneNumber;
  final String code;
  VerifyCodeEvent(this.phoneNumber, this.code);
  @override
  // TODO: implement props
  List<Object?> get props => [phoneNumber, code];

}

part of 'splash_bloc.dart';

class SplashState extends Equatable {

  const SplashState({this.isTimerFinished = false, this.selectLanguage=false});
  final bool isTimerFinished;
  final bool selectLanguage;

  @override
  List<Object?> get props => [isTimerFinished, selectLanguage];
}


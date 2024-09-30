part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {}

class PostUserDataEvent extends RegisterEvent {
  final String surname;
  final String name;
  final String birthday;
  final String phoneNumber;
  final String gender;

  PostUserDataEvent(
    this.surname,
    this.name,
    this.birthday,
    this.phoneNumber,
    this.gender,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [surname, name, birthday, phoneNumber, gender];
}

class UpdateUserDataEvent extends RegisterEvent{
  final String id;
  final String surname;
  final String name;
  final String birthday;
  final String phoneNumber;
  final String gender;

  UpdateUserDataEvent(
      this.surname,
      this.name,
      this.birthday,
      this.id,
      this.phoneNumber,
      this.gender,
      );
  @override
  // TODO: implement props
  List<Object?> get props =>[id, surname, name, birthday, phoneNumber, gender];

}

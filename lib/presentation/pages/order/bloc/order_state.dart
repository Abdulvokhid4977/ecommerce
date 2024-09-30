part of 'order_bloc.dart';


abstract class OrderState extends Equatable {}

class OrderInitial extends OrderState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class OrderLoading extends OrderState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class OrderCreated extends OrderState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class OrderFetched extends OrderState{

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
class OrderError extends OrderState{
  final String message;
  OrderError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];

}

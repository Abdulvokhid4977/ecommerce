part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {}
class OrderCreateEvent extends OrderEvent{
  final List<CartItemWrapper> products;
  final String customerId;
  final String deliveryStatus;
  final String paymentMethod;
  final String paymentStatus;
  OrderCreateEvent(this.products, this.customerId, this.deliveryStatus, this.paymentMethod, this.paymentStatus);

  @override
  List<Object?> get props =>
      [products, customerId, deliveryStatus, paymentMethod, paymentStatus];
}

class FetchOrderEvent extends OrderEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

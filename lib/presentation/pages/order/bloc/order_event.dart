part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {}

class OrderCreateEvent extends OrderEvent {
  final List<CartItemWrapper> products;
  final String customerId;
  final double latitude;
  final double longitude;
  final String address;
  final String deliveryStatus;
  final String paymentMethod;
  final String paymentStatus;

  OrderCreateEvent(
    this.products,
    this.customerId,
    this.deliveryStatus,
    this.paymentMethod,
    this.paymentStatus,
    this.address,
    this.longitude,
    this.latitude,
  );

  @override
  List<Object?> get props => [
        products,
        customerId,
        deliveryStatus,
        paymentMethod,
        paymentStatus,
        address,
        latitude,
        longitude
      ];
}

class FetchOrderEvent extends OrderEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

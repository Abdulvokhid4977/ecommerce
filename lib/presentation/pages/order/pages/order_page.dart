import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/components/custom_container.dart';
import 'package:e_commerce/presentation/pages/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(FetchOrderEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Мои заказы',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colours.blueCustom,
            size: 24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderInitial) {
            return Center(
              child: Lottie.asset('assets/lottie/loading.json',
                  height: 140, width: 140),
            );
          } else if (state is OrderError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is OrderFetched) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemBuilder: (ctx, i) {
                return Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Заказ N# ${state.order[i].order.id.substring(0, 7)}'),
                          CustomContainer().customBox(
                            state.order[0].order.status,
                            Colours.greenIndicator,
                            Colors.white,
                          ),
                        ],
                      ),
                      AppUtils.kHeight16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Дата заказа '),
                          Text(
                              '${state.order[i].order.createdAt.day}/${state.order[i].order.createdAt.month}/${state.order[i].order.createdAt.year}'),
                        ],
                      ),
                      AppUtils.kHeight16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Товар '),
                          Text(AppUtils.numberFormatter(
                              state.order[i].order.totalPrice)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text('Показать товар'))
                        ],
                      ),
                    ],
                  ),
                ));
              },
              itemCount: state.order.length,
            );
          } else {
            return Center(
              child: Lottie.asset('assets/lottie/loading.json',
                  height: 140, width: 140),
            );
          }
        },
      ),
    );
  }
}

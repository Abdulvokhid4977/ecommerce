import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cart_service.dart';
import 'package:e_commerce/core/services/location_service.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/core/wrappers/cart_item_wrapper.dart';
import 'package:e_commerce/presentation/pages/order/bloc/order_bloc.dart';
import 'package:e_commerce/presentation/components/empty_widget.dart';
import 'package:e_commerce/presentation/pages/order/widgets/address.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class GivingOrder extends StatefulWidget {
  final double total;
  final int quantity;
  final double discount;
  final List<CartItemWrapper> products;

  const GivingOrder(
      {super.key,
      required this.total,
      required this.quantity,
      required this.discount,
      required this.products});

  @override
  State<GivingOrder> createState() => _GivingOrderState();
}

class _GivingOrderState extends State<GivingOrder> {
  bool itemOne = false;
  bool itemTwo = false;
  final formKey = GlobalKey<FormState>();
  Icon checkIcon = Icon(
    Icons.check,
    color: Colours.greenIndicator,
  );

  @override
  void didChangeDependencies() {
    SizeConfig().init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Оформление заказа',
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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText('Город получения'),
                AppUtils.kHeight16,
                Container(
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: Colours.textFieldGrey,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: "Скоро",
                          backgroundColor: Colours.greenIndicator);
                    },
                    trailing: const Icon(Icons.keyboard_arrow_down_rounded),
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(
                      'Город',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colours.greyIcon,
                      ),
                    ),
                    subtitle: Text(
                      'Ташкент',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                AppUtils.kHeight32,
                customText('Способ получения'),
                AppUtils.kHeight16,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (itemTwo) {
                        setState(() {
                          itemOne = !itemOne;
                          itemTwo = !itemTwo;
                        });
                      } else if (itemOne) {
                        setState(() {
                          itemOne = !itemOne;
                        });
                      } else if (!itemOne && !itemTwo) {
                        setState(() {
                          itemOne = true;
                        });
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colours.textFieldGrey,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        checked(itemOne, 'Пункт выдачи UCommerce'),
                        AppUtils.kHeight10,
                        Row(
                          children: [
                            const SizedBox(
                              width: 40,
                            ),
                            Text(
                              'Можно забрать Завтра,',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              ' бесплатно',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colours.greenIndicator,
                              ),
                            ),
                          ],
                        ),
                        AppUtils.kHeight10,
                        customRow(
                          'Доставка за 1 день',
                          icon: checkIcon,
                        ),
                        AppUtils.kHeight10,
                        customRow(
                          'Срок хранения заказа - 5 дней',
                          icon: checkIcon,
                        ),
                        AppUtils.kHeight10,
                        customRow(
                          'Можно проверить и примерить товар',
                          icon: checkIcon,
                        ),
                        AppUtils.kHeight10,
                        customRow(
                          'Возврат товара быстро и без проблем',
                          icon: checkIcon,
                        ),
                      ],
                    ),
                  ),
                ),
                AppUtils.kHeight16,
                GestureDetector(
                  onTap: () {
                    if (itemOne) {
                      setState(() {
                        itemOne = !itemOne;
                        itemTwo = !itemTwo;
                      });
                    } else if (itemTwo) {
                      setState(() {
                        itemTwo = !itemTwo;
                      });
                    } else if (!itemOne && !itemTwo) {
                      setState(() {
                        itemTwo = true;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colours.textFieldGrey,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        checked(itemTwo, 'Курьером до двери'),
                        AppUtils.kHeight10,
                        Row(
                          children: [
                            const SizedBox(
                              width: 40,
                            ),
                            Text(
                              'Доставим Завтра,',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              ' 20 000 сум',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colours.greenIndicator,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                AppUtils.kHeight32,
                itemOne || itemTwo
                    ? FutureBuilder<LocationWithDetails?>(
                        future: LocationService().findNearestLocation(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: Lottie.asset(
                                    'assets/lottie/loading.json',
                                    height: 100,
                                    width: 100));
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            print(snapshot.data);
                            return Address(
                                itemTwo ? true : false, snapshot.data!);
                          } else {
                            return const Text('No location found');
                          }
                        },
                      )
                    : const SizedBox(),
                AppUtils.kHeight32,
                customText('Получатель заказа'),
                AppUtils.kHeight16,
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      textFormField('Фамилия*'),
                      AppUtils.kHeight16,
                      textFormField('Имя*'),
                      AppUtils.kHeight16,
                      textFormField('Номер телефона*'),
                      AppUtils.kHeight16,
                    ],
                  ),
                ),
                Text(
                  'Мы пришлем уведомление о статусе заказа на указанный вами телефон',
                  softWrap: true,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colours.greyIcon,
                  ),
                ),
                AppUtils.kHeight32,
                customText('Способ оплаты'),
                AppUtils.kHeight16,
                GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: "Скоро", backgroundColor: Colours.greenIndicator);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colours.textFieldGrey,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        checked(false, 'Картой онлайн'),
                        AppUtils.kHeight10,
                        Row(
                          children: [
                            const SizedBox(
                              width: 40,
                            ),
                            Text(
                              'UZCARD, Humo, Visa, MasterCard',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        AppUtils.kHeight10,
                        Row(
                          children: [
                            const SizedBox(
                              width: 40,
                            ),
                            SvgPicture.asset('assets/icons/apple_pay.svg'),
                            AppUtils.kWidth4,
                            SvgPicture.asset('assets/icons/mastercard.svg'),
                            AppUtils.kWidth4,
                            SvgPicture.asset('assets/icons/visa.svg'),
                            AppUtils.kWidth4,
                            SvgPicture.asset('assets/icons/paypal.svg'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                AppUtils.kHeight16,
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colours.textFieldGrey,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      checked(true, 'Наличными или картой при получении'),
                      AppUtils.kHeight10,
                      Row(
                        children: [
                          const SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth! * 0.7,
                            child: Text(
                              'Оплата в пункте выдачи или курьеру при получении заказа',
                              softWrap: true,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppUtils.kHeight32,
                customText('Ваш заказ:'),
                AppUtils.kHeight16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.quantity} товар',
                    ),
                    Text('${AppUtils.numberFormatter(widget.total)} сум'),
                  ],
                ),
                AppUtils.kHeight16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Итого с доставкой:',
                    ),
                    Text(
                        '${AppUtils.numberFormatter(widget.total + 20000)} сум'),
                  ],
                ),
                AppUtils.kHeight10,
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'экономия: ${AppUtils.numberFormatter(widget.discount)} сум',
                    style: GoogleFonts.inter(color: Colours.greenIndicator),
                  ),
                ),
                AppUtils.kHeight16,
                ListTile(
                  title: const Text('Промокод'),
                  trailing: const Icon(Icons.arrow_drop_down),
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: "Скоро", backgroundColor: Colours.greenIndicator);
                  },
                ),
                AppUtils.kHeight32,
                Text(
                  'Размещеная заказ,вы соглащаетесь на обработку персональных данных в соответсвии с Условиями, а так же соглашаетесь с правилами акции',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colours.greyIcon,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.13,
                )
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                color: Colours.backgroundGrey,
                padding: const EdgeInsets.all(16),
                // height: SizeConfig.screenHeight! * 0.15,
                width: SizeConfig.screenWidth,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Итого',
                        ),
                        Text(
                            '${AppUtils.numberFormatter(widget.total + 20000)} сум'),
                      ],
                    ),
                    AppUtils.kHeight16,
                    BlocConsumer<OrderBloc, OrderState>(
                      listener: (context, state) {
                        if (state is OrderCreated) {
                          CartService().clearCart();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const EmptyWidget(
                                'assets/images/success.png',
                                'Успешно',
                                'Ваш заказ успешно был сделан. Спасибо за выбор',
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if(state is OrderError) {
                          if (kDebugMode) {
                            print(state.message);
                          }
                        }
                        if (state is OrderLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return elevatedButton(
                          'Оформить заказ',
                          Colours.blueCustom,
                          Colors.white,
                          context,
                        );
                      },
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget elevatedButton(
      String text, Color color1, Color color2, BuildContext context,
      {bool isDelivery = false}) {
    return ElevatedButton(
      onPressed: () {
        context.read<OrderBloc>().add(
              OrderCreateEvent(
                  widget.products,
                  "27ca97c2-185d-43a2-b8b3-9fe3363838de",
                  'pochta',
                  'naxt',
                  'kutilmoqda'),
            );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fixedSize:
            Size(SizeConfig.screenWidth!, SizeConfig.screenHeight! * 0.06),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: color2,
        ),
      ),
    );
  }
}

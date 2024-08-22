import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/components/cart_listview.dart';
import 'package:e_commerce/presentation/components/custom_container.dart';
import 'package:e_commerce/presentation/components/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final bool _isCartEmpty = false;
  int? total = 90000;
  int num = 0;

  List<bool> isSelected = [true, true];

  bool isAllSelected() {
    return isSelected.every((item) => item == true);
  }

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
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Корзина',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: _isCartEmpty
          ? const EmptyWidget(
              'assets/images/shopping_bag.png',
              'Корзина пуста',
              'В вашей корзине нет товаров, подберите на товары главной странице',
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colours.textFieldGrey,
                        ),
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight! * 0.18,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Бесплатно доставим в пункт выдачи',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colours.greyIcon,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.question_mark_rounded,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Осталось 360 000 сум до бесплатной доставки курьером',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colours.greyIcon,
                              ),
                            ),
                            AppUtils.kHeight16,
                            LinearPercentIndicator(
                              barRadius: const Radius.circular(8),
                              percent: total! * 0.000001,
                              width: SizeConfig.screenWidth! - 64,
                              backgroundColor: Colors.white,
                              progressColor: Colours.greenIndicator,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '1000000 сум',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colours.greyIcon,
                                    ),
                                  ),
                                  AppUtils.kWidth12,
                                  Icon(
                                    Icons.home,
                                    color: Colours.greyIcon,
                                    size: 16,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      AppUtils.kHeight10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Удалить выбранные',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colours.greyIcon,
                            ),
                          ),
                          Checkbox(
                              activeColor: Colours.blueCustom,
                              value: isAllSelected(),
                              onChanged: (val) {
                                setState(() {
                                  isSelected.replaceRange(
                                    0,
                                    isSelected.length - 1,
                                    List<bool>.filled(
                                        isSelected.length - 0, val!),
                                  );
                                });
                              }),
                        ],
                      ),
                      AppUtils.kHeight10,
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/s22.jpg',
                                    height: 110,
                                    width: 80,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: SizeConfig.screenWidth! - 128,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '899 000 сум',
                                                      style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    AppUtils.kWidth12,
                                                    Text(
                                                      '950 000 сум',
                                                      style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                        color: Colours.greyIcon,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Checkbox(
                                                  activeColor:
                                                      Colours.blueCustom,
                                                  value: isSelected[i],
                                                  onChanged: (val) {
                                                    setState(() {
                                                      isSelected[i] =
                                                          !isSelected[i];
                                                    });
                                                  }),
                                            ],
                                          ),
                                        ),
                                        AppUtils.kHeight8,
                                        CustomContainer().customBox(
                                          'Временная скидка',
                                          Colours.redCustom,
                                          Colors.white,
                                        ),
                                        AppUtils.kHeight16,
                                        Text(
                                          'Samsung S22 Ultra 12/256gb Black ',
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 76,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colours.backgroundGrey,
                                    ),
                                    margin: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                          ),
                                          margin: const EdgeInsets.all(8),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (num > 0) {
                                                setState(() {
                                                  num--;
                                                });
                                              }
                                            },
                                            child: const Icon(
                                              Icons.remove,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                        AppUtils.kWidth8,
                                        Text(
                                          num.toString(),
                                        ),
                                        AppUtils.kWidth8,
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                          ),
                                          margin: const EdgeInsets.all(8),
                                          child: GestureDetector(
                                            onTap: () {
                                              num++;
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        itemCount: 2,
                      ),
                      AppUtils.kHeight16,
                      Text(
                        'Ваш заказ: ',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      AppUtils.kHeight10,
                      customRow('1 товар: ', '950 000 сум'),
                      AppUtils.kHeight10,
                      customRow('Скидки на товары:: ', '-51 000 сум'),
                      AppUtils.kHeight10,
                      customRow('Итого:* ', '950 000 сум', isTotal: true),
                      AppUtils.kHeight10,
                      Center(
                        child: Text(
                          '*Окончательная стоимость будет рассчитана после выбора способа доставки при оформлении заказа',
                          style: GoogleFonts.inter(
                            color: Colours.greyIcon,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          softWrap: true,
                        ),
                      ),
                      AppUtils.kHeight32,
                      Text(
                        'Рекоммендуемое',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      CartListview().category('category', context),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.1,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: SizeConfig.screenHeight! * 0.1,
                    width: SizeConfig.screenWidth,
                    color: Colours.backgroundGrey,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '899 000 сум',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '1 товар',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colours.greyIcon,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.givingOrder);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colours.blueCustom,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              fixedSize: const Size(150, 50)),
                          child: Text(
                            'Оформить',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget customRow(String text1, String text2, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        Text(
          text2,
          style: isTotal
              ? GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                )
              : GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
        ),
      ],
    );
  }
}

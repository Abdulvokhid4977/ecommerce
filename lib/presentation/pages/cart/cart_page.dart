import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/components/custom_container.dart';
import 'package:e_commerce/presentation/components/empty_widget.dart';
import 'package:e_commerce/presentation/pages/cart/widgets/custom_listview.dart';
import 'package:e_commerce/presentation/pages/cart/widgets/indicator_container.dart';
import 'package:e_commerce/presentation/pages/cart/widgets/recommend.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/custom_row.dart';
import 'widgets/fixed_bottom.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final bool _isCartEmpty = false;

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
                      const IndicatorContainer(),
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
                      CustomListview(isSelected),
                      AppUtils.kHeight16,
                      Text(
                        'Ваш заказ: ',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      AppUtils.kHeight10,
                      const CustomRow('1 товар: ', '950 000 сум'),
                      AppUtils.kHeight10,
                      const CustomRow('Скидки на товары:: ', '-51 000 сум'),
                      AppUtils.kHeight10,
                      const CustomRow('Итого:* ', '950 000 сум', isTotal: true),
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
                      const Recommend(),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.1,
                      ),
                    ],
                  ),
                ),
                const FixedBottom(),
              ],
            ),
    );
  }
}

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/components/empty_widget.dart';
import 'package:e_commerce/presentation/components/modalsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GivingOrder extends StatefulWidget {
  const GivingOrder({super.key});

  @override
  State<GivingOrder> createState() => _GivingOrderState();
}

class _GivingOrderState extends State<GivingOrder> {
  bool itemOne = true;
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
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colours.blueCustom,
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
                      modalBottomSheet(context);
                    },
                    trailing: const Icon(Icons.keyboard_arrow_down_rounded),
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(
                      'Город*',
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
                              ' бесплатно',
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
                customText('Адрес доставки'),
                AppUtils.kHeight16,
                customRow(
                  'Пункт выдачи UCommerce',
                  icon: const Icon(Icons.location_on_outlined),
                ),
                AppUtils.kHeight10,
                customRow(
                    'г.Ташкент, Мирзо Улугбекский район, улица Мирзо Улугбек, 87 дом',
                    hasIcon: false),
                AppUtils.kHeight10,
                customRow('10:00-20:00, без выходных', hasIcon: false),
                AppUtils.kHeight16,
                elevatedButton(
                    'Изменить', Colours.textFieldGrey, Colors.black, false),
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
                      checked(true, 'Картой онлайн'),
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
                      checked(false, 'Наличными или картой при получении'),
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1 товар',
                    ),
                    Text('1 919 00 сум'),
                  ],
                ),
                AppUtils.kHeight16,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Итого:*',
                    ),
                    Text('1 919 00 сум'),
                  ],
                ),
                AppUtils.kHeight10,
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'экономия: 1 078 000 сум',
                    style: GoogleFonts.inter(color: Colours.greenIndicator),
                  ),
                ),
                AppUtils.kHeight16,
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: SizeConfig.screenHeight! * 0.07,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: Colours.textFieldGrey,
                  ),
                  child: TextField(
                    cursorColor: Colours.greyIcon,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Промокод',
                      labelStyle: TextStyle(color: Colours.greyIcon),
                    ),
                  ),
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Итого',
                        ),
                        Text('1 919 00 сум'),
                      ],
                    ),
                    AppUtils.kHeight16,
                    elevatedButton(
                        'Оформить заказ', Colours.blueCustom, Colors.white, true),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget elevatedButton(String text, Color color1, Color color2, bool isDone) {
    return ElevatedButton(
      onPressed: () {
        if(isDone) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
              const EmptyWidget('assets/images/success.png',
                  'Успешно', 'Ваш заказ успешно был сделан. Спасибо за выбор'),
            ),
          );
        }
        return;
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

  Widget textFormField(String text) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      height: SizeConfig.screenHeight! * 0.07,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colours.textFieldGrey,
      ),
      child: TextFormField(
        cursorColor: Colours.greyIcon,
        decoration: InputDecoration(
            border: InputBorder.none,
            label: Text(text),
            labelStyle: TextStyle(color: Colours.greyIcon)),
      ),
    );
  }

  Widget customRow(String text,
      {Icon icon = const Icon(Icons.location_on_outlined),
      bool hasIcon = true}) {
    return Row(
      children: [
        hasIcon
            ? icon
            : const SizedBox(
                width: 24,
              ),
        AppUtils.kWidth16,
        SizedBox(
          width: SizeConfig.screenWidth! * 0.7,
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget checked(bool isChecked, String text) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: isChecked ? Colours.blueCustom : Colors.black, width: 2),
          ),
          child: Center(
            child: Container(
              width: 13,
              height: 13,
              decoration: isChecked
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colours.blueCustom,
                    )
                  : null,
            ),
          ),
        ),
        AppUtils.kWidth16,
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget customText(String text1) {
    return Text(
      text1,
      style: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  void modalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: context,
        isDismissible: true,
        builder: (context) {
          return const ModalSheet();
        });
  }
}

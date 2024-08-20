import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/components/modalsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GivingOrder extends StatefulWidget {
  const GivingOrder({super.key});

  @override
  State<GivingOrder> createState() => _GivingOrderState();
}

class _GivingOrderState extends State<GivingOrder> {
  bool itemOne = true;
  bool itemTwo = false;
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
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText('Город получения'),
            AppUtils.kHeight16,
            Container(
              decoration: BoxDecoration(
                color: Colours.backgroundGrey,
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
                  color: Colours.backgroundGrey,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        checked(itemOne),
                        AppUtils.kWidth16,
                        Text(
                          'Пункт выдачи UCommerce',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
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
                  color: Colours.backgroundGrey,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        checked(itemTwo),
                        AppUtils.kWidth16,
                        Text(
                          'Курьером до двери',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
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
            customRow('Пункт выдачи UCommerce',icon: const Icon(Icons.location_on_outlined),),
            AppUtils.kHeight10,
            customRow('г.Ташкент, Мирзо Улугбекский район, улица Мирзо Улугбек, 87 дом',  hasIcon: false),
            AppUtils.kHeight10,
            customRow('10:00-20:00, без выходных',hasIcon: false),
            AppUtils.kHeight10,

          ],
        ),
      ),
    );
  }

  Widget customRow(String text, {Icon icon= const Icon(Icons.location_on_outlined),bool hasIcon=true}) {
    return Row(
      children: [
        hasIcon? icon: const SizedBox(width: 24,),
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

  Widget checked(bool isChecked) {
    return Container(
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

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cart_service.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/core/wrappers/cart_item_wrapper.dart';
import 'package:e_commerce/presentation/components/empty_widget.dart';
import 'package:e_commerce/presentation/pages/cart/widgets/custom_listview.dart';
import 'package:e_commerce/presentation/pages/cart/widgets/custom_row.dart';
import 'package:e_commerce/presentation/pages/cart/widgets/fixed_bottom.dart';
import 'package:e_commerce/presentation/pages/cart/widgets/indicator_container.dart';
import 'package:e_commerce/presentation/pages/cart/widgets/recommend.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartService = GetIt.I<CartService>();
  List<CartItemWrapper> products = [];
  List<bool> selectedItems = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final loadedProducts = await cartService.getCartProducts();
    setState(() {
      products = loadedProducts;
      selectedItems = List.generate(products.length, (_) => true);
    });
  }

  void updateQuantity(int index, int newQuantity) {
    setState(() {
      products[index].quantity = newQuantity;
    });
    cartService.updateProductQuantity(products[index].product, newQuantity);
  }

  bool get isCartEmpty => products.isEmpty;

  bool isAllSelected() => selectedItems.every((item) => item);

  void toggleAllSelection(bool? value) {
    setState(() {
      selectedItems = List.generate(products.length, (_) => value ?? false);
    });
  }

  void deleteSelectedItems() async {
    List<String> idsToDelete = [];
    for (int i = selectedItems.length - 1; i >= 0; i--) {
      if (selectedItems[i]) {
        idsToDelete.add(products[i].product.id);
        products.removeAt(i);
        selectedItems.removeAt(i);
      }
    }
    await cartService.removeFromCart(idsToDelete);
    setState(() {});
  }

  double calculateTotalPrice() {
    double total = 0;

    for (var item in products) {
      total += item.product.price * item.quantity;
    }

    return total;
  }

  double discount() {
    double total = 0;
    for (var item in products) {
      total += (item.product.price - item.product.withDiscount) * item.quantity;
    }

    return total;
  }
  int amount(){
    int total=0;
    for(var item in products){
      total+= item.quantity;
    }
    return total;
  }

   showDeleteConfirmationDialog(BuildContext context) async {
    return PanaraConfirmDialog.showAnimatedGrow(
      context,
      title: "Удаление",
      message: "Вы действительно хотите удалить?",
      confirmButtonText: "Удалить",
      cancelButtonText: "Отмена",
      onTapCancel: () {
        Navigator.pop(context);
      },
      onTapConfirm: () {
        deleteSelectedItems();
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.error,
      noImage: true,
    );
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
      body: isCartEmpty
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
                      IndicatorContainer(calculateTotalPrice() - discount()),
                      AppUtils.kHeight10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              showDeleteConfirmationDialog(context);
                            },
                            child: Text(
                              'Удалить выбранные',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colours.redCustom,
                              ),
                            ),
                          ),
                          Checkbox(
                            activeColor: Colours.blueCustom,
                            value: isAllSelected(),
                            onChanged: toggleAllSelection,
                          ),
                        ],
                      ),
                      AppUtils.kHeight10,
                      CustomListview(
                        products: products,
                        selectedItems: selectedItems,
                        onItemSelected: (index, value) {
                          setState(() {
                            selectedItems[index] = value;
                          });
                        },
                        onQuantityChanged: updateQuantity,
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
                      CustomRow('${amount()} товар: ',
                          '${AppUtils.numberFormatter(calculateTotalPrice())} сум'),
                      AppUtils.kHeight10,
                      CustomRow('Скидки на товары:: ',
                          '-${AppUtils.numberFormatter(discount())} сум'),
                      AppUtils.kHeight10,
                      CustomRow('Итого:* ',
                          '${AppUtils.numberFormatter(calculateTotalPrice() - discount())} сум',
                          isTotal: true),
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
                FixedBottom(
                  calculateTotalPrice() - discount(),
                  amount(),
                ),
              ],
            ),
    );
  }
}

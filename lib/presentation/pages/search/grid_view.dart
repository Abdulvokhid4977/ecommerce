import 'package:e_commerce/data/models/category_model.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../data/models/product_model.dart';
import '../../components/gridtile.dart';

class GridViewWidget extends StatelessWidget {
  final List<ProductElement> product;
  final int i;
  final List<CategoryElement>? category;
  const GridViewWidget(this.product, this.i, {super.key, this.category});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colours.blueCustom,
            )),
        title: Text(
          'Results for: ${product[i].name}',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: product.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              mainAxisExtent: SizeConfig.screenHeight! * 0.4,
            ),
            itemBuilder: (ctx, i) {
              return GridTileProduct(
                product[i].favorite,
                product[i],
              );
            }),
      ),
    );
  }
}

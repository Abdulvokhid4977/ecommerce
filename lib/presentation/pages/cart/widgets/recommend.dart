import 'package:e_commerce/presentation/pages/details/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../components/custom_container.dart';

class Recommend extends StatelessWidget {
  const Recommend({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: SizeConfig.screenHeight! * 0.4,
          padding: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Constants.products.product.isEmpty
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, i) {
                      return Container(
                        margin: const EdgeInsets.only(left: 16),
                        width: SizeConfig.screenWidth! * 0.4,
                        height: 0.38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    },
                    itemCount: 5,
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (_, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              product: Constants.products.product[i],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 16),
                        width: SizeConfig.screenWidth! * 0.4,
                        height: 0.38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                child: Image.network(
                                  Constants
                                      .products.product[i].color[0].colorUrl[0],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            AppUtils.kHeight10,
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.05,
                              child: Text(
                                Constants.products.product[i].name,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                                softWrap: true,
                              ),
                            ),
                            AppUtils.kHeight10,
                            CustomContainer().customBox(
                              '109 378 сум/мес',
                              Colours.yellowCustom2,
                              Colors.black,
                            ),
                            AppUtils.kHeight10,
                            Text(
                              '${AppUtils.numberFormatter(Constants.products.product[i].price)} сум',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                ),
        ),
      ],
    );
  }
}
//

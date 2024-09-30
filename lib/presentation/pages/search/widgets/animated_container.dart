import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/constants.dart';
import '../../../../data/models/category_model.dart';
import '../bloc/search_bloc.dart';

class CategoryAnimation extends StatelessWidget {

  final List<CategoryElement> subcategories;
  final String? expandedCategoryId;
  final CategoryElement category;
  const CategoryAnimation(this.category, this.expandedCategoryId, this.subcategories,{super.key});


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: expandedCategoryId == category.id
          ? subcategories.length * 60.0
          : 0,
      duration: const Duration(milliseconds: 300),
      child: ListView.builder(
        itemCount: subcategories.length,
        shrinkWrap: true,
        physics:
        const NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, subIndex) {
          CategoryElement subcategory =
          subcategories[subIndex];
          return ListTile(
            leading: Container(
              margin:
              const EdgeInsets.only(left: 32),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(4),
                color: Colours.backgroundGrey,
              ),
              height: 24,
              width: 24,
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(4),
                child: Image.network(
                  subcategory.url,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              ),
            ),
            title: Text(
              subcategory.name,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            onTap: () {
              if (subcategory.id.isNotEmpty) {
                context.read<SearchBloc>().add(
                    FetchSearchDataEvent(
                        subcategory.id,
                        false));
              }
            },
          );
        },
      ),
    );
  }
}

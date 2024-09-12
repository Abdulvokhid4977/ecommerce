import 'package:e_commerce/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../bloc/main/main_bloc.dart';
import '../../../bloc/search/search_bloc.dart' as search;
import '../../search/pages/search_page.dart';

class CategoryWidget extends StatefulWidget {
  final List<CategoryElement> filtered;
  const CategoryWidget(this.filtered,{super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight! * 0.15,
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        separatorBuilder: (ctx, i) {
          return AppUtils.kWidth8;
        },
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          return GestureDetector(
            onTap: () {
              context
                  .read<MainBloc>()
                  .add(ChangeTabEvent(1));
              context.read<search.SearchBloc>().add(
                  search.FetchSearchDataEvent(
                      widget.filtered[i].id, false));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SearchPage(),
                ),
              );
            },
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(8),
                    child: Image.network(
                      widget.filtered[i].url,
                      // state.category.category[i].url,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                AppUtils.kHeight10,
                SizedBox(
                  width: SizeConfig.screenWidth! * 0.195,
                  child: Text(
                    widget.filtered[i].name,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: widget.filtered.length,
      ),
    );
  }
}

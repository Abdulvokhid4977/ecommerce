import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/shimmers/search_shimmer.dart';
import 'package:e_commerce/data/models/category_model.dart';
import 'package:e_commerce/presentation/bloc/search/search_bloc.dart';
import 'package:e_commerce/presentation/components/gridtile.dart';
import 'package:e_commerce/presentation/components/textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  final String id;

  const SearchPage(this.id, {super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final focus1 = FocusNode();
  final textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 16,
              top: SizeConfig.statusBar! + 20,
              right: 16,
            ),
            child: textField(
              () {},
              focus1,
              textEditingController,
              "Поиск товаров и категорий",
              isSearch: true,
            ),
          ),
          BlocBuilder<SearchBloc, SearchState>(
              bloc: context.read<SearchBloc>(),
              builder: (context, state) {
                if (kDebugMode) {
                  print(state.runtimeType);
                }
                if (state is SearchLoading) {
                  return const Expanded(
                    child: SearchShimmer(),
                  );
                } else if (state is CategoryLoaded) {
                  List<CategoryElement> filtered = state.category.category
                      .where((val) => val.parentId == '')
                      .toList();
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (ctx, i) {
                          return ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colours.backgroundGrey,
                              ),
                              height: 48,
                              width: 48,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  filtered[i].url,
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            title: Text(
                              filtered[i].name,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                            ),
                            onTap: () {},
                          );
                        },
                        separatorBuilder: (c, i) {
                          return Divider(
                            color: Colours.backgroundGrey,
                            thickness: 1,
                          );
                        },
                        itemCount: filtered.length,
                      ),
                    ),
                  );
                } else if (state is FetchCategoryProductState) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.product.product.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            mainAxisExtent: SizeConfig.screenHeight! * 0.46,
                          ),
                          itemBuilder: (ctx, i) {
                            return GridTileProduct(
                                i,
                                state.product.product[i].favorite,
                                state.product.product[i],
                                context.read<SearchBloc>());
                          }),
                    ),
                  );
                } else if (state is SearchError) {
                  return Center(
                    child: Text(
                        'This is coming from search screen ${state.message}'),
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/shimmers/search_shimmer.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/data/models/category_model.dart';
import 'package:e_commerce/presentation/pages/search/bloc/search_bloc.dart';
import 'package:e_commerce/presentation/components/gridtile.dart';
import 'package:e_commerce/presentation/pages/search/widgets/grid_view.dart';
import 'package:e_commerce/presentation/pages/search/pages/search_list.dart';
import 'package:e_commerce/presentation/pages/search/widgets/animated_container.dart';
import 'package:e_commerce/presentation/pages/search/widgets/searchbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../bloc/main/main_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textEditingController = TextEditingController();
  String? expandedCategoryId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: context.read<SearchBloc>(),
      builder: (context, state) {
        if (kDebugMode) {
          print(state.runtimeType);
        }
        if (state is SearchLoading) {
          return Scaffold(
            body: Column(
              children: [
                Searchbar(
                  textEditingController,
                  () {},
                  isSearchbarNeeded: false,
                ),
                const Expanded(
                  child: SearchShimmer(),
                )
              ],
            ),
          );
        } else if (state is CategoryLoaded) {
          List<CategoryElement> filtered = state.category.category
              .where((val) => val.parentId == '')
              .toList();
          return Scaffold(
            body: Column(
              children: [
                Searchbar(
                  textEditingController,
                  () {},
                  isSearchbarNeeded: false,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        CategoryElement category = filtered[i];

                        // Get subcategories
                        List<CategoryElement> subcategories = state
                            .category.category
                            .where((val) => val.parentId == category.id)
                            .toList();

                        return Column(
                          children: [
                            ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colours.backgroundGrey,
                                ),
                                height: 48,
                                width: 48,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: category.url,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => Lottie.asset(
                                        'assets/lottie/loading.json',
                                        height: 140,
                                        width: 140),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              title: Text(
                                category.name,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              trailing: Icon(
                                expandedCategoryId == category.id &&
                                        subcategories.isNotEmpty
                                    ? Icons.expand_less
                                    : Icons.arrow_forward_ios_rounded,
                              ),
                              onTap: () {
                                if (subcategories.isNotEmpty) {
                                  setState(() {
                                    expandedCategoryId =
                                        expandedCategoryId == category.id
                                            ? null
                                            : category.id;
                                  });
                                } else {
                                  if (category.id.isNotEmpty) {
                                    context.read<SearchBloc>().add(
                                        FetchSearchDataEvent(
                                            category.id, false));
                                  }
                                }
                              },
                            ),
                            if (subcategories.isNotEmpty)
                              CategoryAnimation(
                                  category, expandedCategoryId, subcategories),
                          ],
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
                )
              ],
            ),
          );
        } else if (state is SearchSuccess) {
          if (!state.isCompleted) {
            return Scaffold(
              body: Column(
                children: [
                  Searchbar(
                    textEditingController,
                    () {
                      Navigator.of(context).pushNamed(Routes.main);
                    },
                  ),
                  Expanded(
                    child: SearchList(state.products.product,
                        state.category!.category, textEditingController),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              body: Column(
                children: [
                  Searchbar(textEditingController, () {}),
                  AppUtils.kHeight32,
                  Expanded(child: GridViewWidget(state.products)),
                ],
              ),
            );
          }
        } else if (state is FetchCategoryProductLoading) {
          return Scaffold(
            body: Column(
              children: [
                Searchbar(
                  textEditingController,
                  () {},
                ),
                const Expanded(
                  child: SearchShimmer(),
                )
              ],
            ),
          );
        } else if (state is FetchCategoryProductState) {
          return Scaffold(
            body: Column(
              children: [
                Searchbar(
                  textEditingController,
                  () {},
                ),
                state.product.product.isNotEmpty
                    ? Expanded(
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
                                  state.product.product[i].favorite,
                                  state.product.product[i],
                                );
                              }),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                              child: Text('No product for this category'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<MainBloc>().add(ChangeTabEvent(0));
                              },
                              child: const Text('Go back'),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          );
        } else if (state is SearchError) {
          return Scaffold(
            body: Column(
              children: [
                Searchbar(
                  textEditingController,
                  () {},
                ),
                Center(
                  child: Text(
                      'This is coming from search screen ${state.message}'),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Column(
              children: [
                Searchbar(
                  textEditingController,
                  () {},
                ),
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

import 'package:e_commerce/core/services/cached_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/constants.dart';
import '../../../bloc/search/search_bloc.dart';

class Searchbar extends StatefulWidget {
  final TextEditingController controller;
  final Function function;
  final bool isSearchbarNeeded;

  const Searchbar(
    this.controller,
    this.function, {
    super.key,
    this.isSearchbarNeeded = true,
  });

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final focus1 = FocusNode();

  @override
  void initState() {
    super.initState();
    focus1.requestFocus();
  }

  @override
  void dispose() {
    focus1.dispose();
    super.dispose();
  }
  Future<void> saveToMem()async{
    await SearchHistoryManager.saveSearchedProduct(
        widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.screenWidth! * 0.02,
          top: SizeConfig.statusBar! + 20,
          right: SizeConfig.screenWidth! * 0.02,
          bottom: 16,
        ),
        child: Row(
          children: [
            // Back button
            widget.isSearchbarNeeded
                ? IconButton(
                    onPressed: () {
                      widget.function;
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colours.blueCustom,
                      size: SizeConfig.screenWidth! * 0.07,
                    ),
                  )
                : const SizedBox(),

            Expanded(
              child: TextField(
                  focusNode: focus1,
                  controller: widget.controller,
                  onTapOutside: (tap) {
                    focus1.unfocus();
                  },
                  onTap: () {
                    if (focus1.hasFocus) {
                      return;
                    }
                    context.read<SearchBloc>().add(SearchQueryChangedEvent(null));
                  },
                  onChanged: (query) {
                    context.read<SearchBloc>().add(SearchQueryChangedEvent(query));
                  },
                  decoration: InputDecoration(
                    hintText: "Поиск товаров и категорий",
                    hintStyle: TextStyle(color: Colours.greyIcon),
                    filled: true,
                    fillColor: Colours.textFieldGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          widget.controller.clear();
                        },
                        icon: const Icon(Icons.clear)),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        'assets/icons/search.svg',
                        colorFilter: ColorFilter.mode(
                          Colours.greyIcon,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.text,
                  onSubmitted: (s)  {
                    focus1.unfocus();
                    if (s.isNotEmpty) {
                      saveToMem();
                      context.read<SearchBloc>().add(SearchQueryChangedEvent(s));

                    }
                  }),
            ),
          ],
        ));
  }
}

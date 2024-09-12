import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/constants.dart';
import '../../../bloc/search/search_bloc.dart';

class Searchbar extends StatefulWidget {
  final FocusNode focus;
  final TextEditingController controller;

  const Searchbar(this.controller, this.focus, {super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
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
          IconButton(
            onPressed: () {
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colours.blueCustom,
              size: SizeConfig.screenWidth! * 0.07,
            ),
          ),


          Expanded(
            child: TextField(
              focusNode: widget.focus,
              controller: widget.controller,
              onTapOutside: (tap){widget.focus.unfocus();},
              onTap: () {
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
                suffixIcon: widget.controller.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    widget.controller.clear();
                    setState(() {});
                  },
                )
                    : null,
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
              onSubmitted: (s) => widget.focus.unfocus(),
            ),
          ),
        ],
      ),
    );
  }
}

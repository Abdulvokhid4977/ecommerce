import 'package:e_commerce/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/constants.dart';
import '../../../bloc/main/main_bloc.dart';
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
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.only(
        left: 8,
        top: SizeConfig.statusBar! + 20,
        right: 8,
        bottom: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              autofocus: false,
              onTap: (){
                context.read<MainBloc>().add(ChangeTabEvent(1));
                context.read<SearchBloc>().add(SearchQueryChangedEvent(null));
                },
              readOnly: true,
              textCapitalization: TextCapitalization.words,
              onChanged: (query) {
                context.read<SearchBloc>().add(SearchQueryChangedEvent(query));
              },
              decoration: InputDecoration(
                hintText: "Поиск товаров и категорий",
                hintStyle: TextStyle(color: Colours.greyIcon),
                border: InputBorder.none,
                filled: true,
                fillColor: Colours.textFieldGrey,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 0,
                    color: Color.fromRGBO(243, 243, 243, 1),
                  ),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
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
              controller: widget.controller,
              keyboardType: TextInputType.text,
              onSubmitted: (s) {
                widget.focus.unfocus();
              },
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<MainBloc>().add(FetchDataEvent(true));
              Navigator.of(context).pushNamed(Routes.favorites);
            },
            icon: Icon(
              Icons.favorite_border,
              color: Colours.greyIcon,
              size: SizeConfig.screenWidth! * 0.07,
            ),
          ),
        ],
      ),
    );
  }
}

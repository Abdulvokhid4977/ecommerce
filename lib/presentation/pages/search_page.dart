import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

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
    context.read<MainBloc>().add(FetchDataEvent(false));
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      bloc: context.read<MainBloc>(),
      builder: (context, state) {
        if(state is MainLoaded) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: SizeConfig.statusBar! + 20,
                    right: 16,
                    bottom: 16,
                  ),
                  child: textField(
                        () {},
                    focus1,
                    textEditingController,
                    "Поиск товаров и категорий",
                    isSearch: true,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
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
                            child: Image.network(
                              state.category.category[i].url,
                              alignment: Alignment.center,
                            ),
                          ),
                          title: Text(
                            state.category.category[i].name,
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
                      itemCount: state.category.category.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        else if(state is MainError){
          return Center(child: Text(state.message),);
        }else {
          return const Center(child: CircularProgressIndicator());
        }


      },
    );
  }
}

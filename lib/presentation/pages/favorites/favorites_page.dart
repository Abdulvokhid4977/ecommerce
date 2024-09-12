import 'package:e_commerce/core/constants/constants.dart';
// import 'package:e_commerce/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/pages/favorites/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}


class _FavoritesPageState extends State<FavoritesPage> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      bloc: context.read<MainBloc>(),
      builder: (context, state) {
        if (state is MainLoading) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.read<MainBloc>().add(FetchDataEvent(false));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colours.blueCustom,
                  )),
              backgroundColor: Colours.backgroundGrey,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
              ),
              elevation: 0,
              title: Text(
                'Мои желания',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Colors.black),
              ),
            ),
            body: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(

                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    mainAxisExtent: MediaQuery.of(context).size.height * 0.46,
                  ),
                  itemCount: 4,
                  // Adjust based on your needs
                  itemBuilder: (_, __) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      margin: const EdgeInsets.all(8),
                    );
                  },
                ),
              ),
            ),
          );
        }
        else if (state is FetchWishlistState) {
          return Wishlist(state.product);
        } else if (state is MainError) {
          return Center(child: Text(state.message));
        }else if(state is FavoriteToggledState){
          return const SizedBox();
        } else {
          return const Scaffold(body: Center(child: Text('Could not fetch Favorites Page'),),);
        }
      },
    );
  }
}

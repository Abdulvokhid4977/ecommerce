import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/presentation/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode focus1 = FocusNode();
  final textEditingController = TextEditingController();

  List<Map> searchCat = [
    {'asset': 'assets/images/cat1.png', 'label': 'Бытовая техника'},
    {'asset': 'assets/images/cat2.png', 'label': 'Электроника'},
    {'asset': 'assets/images/cat3.png', 'label': 'Еда'},
    {'asset': 'assets/images/cat4.png', 'label': 'Спорт'},
    {'asset': 'assets/images/cat5.png', 'label': 'Авто запчасти'},

    {'asset': 'assets/images/cat1.png', 'label': 'Бытовая техника'},
    {'asset': 'assets/images/cat2.png', 'label': 'Электроника'},
    {'asset': 'assets/images/cat3.png', 'label': 'Еда'},
    {'asset': 'assets/images/cat4.png', 'label': 'Спорт'},
    {'asset': 'assets/images/cat5.png', 'label': 'Авто запчасти'},

    {'asset': 'assets/images/cat1.png', 'label': 'Бытовая техника'},
    {'asset': 'assets/images/cat2.png', 'label': 'Электроника'},
    {'asset': 'assets/images/cat3.png', 'label': 'Еда'},
    {'asset': 'assets/images/cat4.png', 'label': 'Спорт'},
    {'asset': 'assets/images/cat5.png', 'label': 'Авто запчасти'},
  ];

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).viewPadding.top;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(

        children: [
          Container(
            width: width,
            padding: EdgeInsets.only(
              left: 16,
              top: statusBar + 20,
              right: 16,
              bottom: 16,
            ),
            color: Colors.white,
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
                itemBuilder: (ctx, i) {
                  return ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colours.backgroundGrey,
                      ),
                      height: 48,
                      width: 48,
                      child: Image.asset(
                        searchCat[i]['asset'],
                        alignment: Alignment.center,
                      ),
                    ),
                    title: Text(
                      searchCat[i]['label'],
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                    onTap: (){},
                  );
                },
                separatorBuilder: (c, i) {
                  return Divider(
                    color: Colours.backgroundGrey,
                    thickness: 1,
                  );
                },
                itemCount: searchCat.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:e_commerce/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalSheet extends StatefulWidget {
  const ModalSheet({super.key});

  @override
  State<ModalSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  final focusNode = FocusNode();
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Выберите город получения',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.cancel,
              color: Colours.greyIcon,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onTap: (){
              },
              textCapitalization: TextCapitalization.words,
              onChanged: (query) {
                // context.read<SearchBloc>().add(SearchQueryChangedEvent(query));
              },
              decoration: InputDecoration(
                hintText: 'Найти город',
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
              controller: textEditingController,
              keyboardType: TextInputType.text,
              onSubmitted: (s) {
                focusNode.unfocus();
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (ctx, i) {
                    return ListTile(
                      title: Text(
                        'Аккурган',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        'Центральная Азия',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colours.greyIcon,
                        ),
                      ),
                    );
                  },
                  itemCount: 10,
                  separatorBuilder: (ctx, i) {
                    return const Divider();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

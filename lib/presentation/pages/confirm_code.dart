import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmCode extends StatefulWidget {
  final String phoneNumber;

  const ConfirmCode(this.phoneNumber, {super.key});

  @override
  State<ConfirmCode> createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
  bool isCodeFilled = false;
  bool _onEditing = false;
  bool _codeCorrect = true;
  final String _code = '1234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colours.blueCustom,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Введите код ',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  AppUtils.kHeight10,
                  Text(
                    'Отправили код  на номер  +998 ${widget.phoneNumber}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colours.greyIcon,
                    ),
                  ),
                  AppUtils.kHeight10,
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Изменить номер',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colours.blueCustom,
                      ),
                    ),
                  ),
                  AppUtils.kHeight16,
                  Center(
                    child: VerificationCode(
                      textStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.number,
                      underlineColor: Colours.blueCustom,
                      underlineUnfocusedColor: _codeCorrect
                          ? Colours.greenIndicator
                          : Colours.redCustom,
                      length: 4,
                      itemSize: 50,
                      fillColor: Colours.textFieldGrey,
                      fullBorder: true,
                      digitsOnly: true,
                      margin: const EdgeInsets.all(10),
                      cursorColor: Colours.blueCustom,
                      clearAll: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Clear all',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colours.blueCustom,
                          ),
                        ),
                      ),
                      onCompleted: (String value) {
                        if (value.compareTo(_code) == 0) {
                          setState(() {
                            _codeCorrect = true;
                            isCodeFilled = true;
                          });
                        } else {
                          setState(() {
                            _codeCorrect = false;
                            isCodeFilled = false;
                          });
                        }
                      },
                      onEditing: (bool value) {
                        setState(() {
                          _onEditing = value;
                        });
                        if (!_onEditing) FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                ],
              ),
            ),
            AppUtils.kHeight16,
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor:
                      isCodeFilled ? Colours.blueCustom : Colours.textFieldGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fixedSize: Size(SizeConfig.screenWidth!, 56)),
              child: Text(
                'Продолжить',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: isCodeFilled ? Colors.white : Colours.greyIcon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

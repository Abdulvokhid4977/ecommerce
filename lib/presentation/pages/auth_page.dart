import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/pages/confirm_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String phoneNumber = '';
  final focusNode = FocusNode();
  final controller = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  bool isNumberFilled = false;

  @override
  void didChangeDependencies() {
    SizeConfig().init(context);
    super.didChangeDependencies();
  }

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
                    'Введите номер телефона ',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  AppUtils.kHeight10,
                  Text(
                    'Отправим смс с кодом подтверждения',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colours.greyIcon,
                    ),
                  ),
                  AppUtils.kHeight32,
                  Text(
                    'Введите номер телефона ',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  AppUtils.kHeight16,
                  TextField(
                    focusNode: focusNode,
                    onSubmitted: (val) {},
                    onChanged: (i) {
                      if (i.length == 12) {
                        setState(() {
                          isNumberFilled = true;
                          phoneNumber = i;
                        });
                      } else {
                        setState(() {
                          isNumberFilled = false;
                        });
                      }
                    },
                    onTapOutside: (i) {
                      focusNode.unfocus();
                    },
                    controller: controller,
                    cursorColor: Colours.blueCustom,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      maskFormatter,
                    ],
                    maxLength: 12,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'XY XYZ XY XY',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          '+998',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: focusNode.hasFocus
                            ? BorderSide(
                                style: BorderStyle.solid,
                                width: 1,
                                color: Colours.blueCustom,
                              )
                            : const BorderSide(
                                style: BorderStyle.none,
                                width: 0,
                              ),
                      ),
                      fillColor: Colours.textFieldGrey,
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'При регистрации вы соглашаетесь с ',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
                children: [
                  TextSpan(
                    text: 'условиями использования',
                    style: GoogleFonts.inter(
                      color: Colours.blueCustom,
                      decoration: TextDecoration.none,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (kDebugMode) {
                          print('Tapped on условиями использования');
                        }
                      },
                  ),
                  const TextSpan(
                    text: ' и ',
                  ),
                  TextSpan(
                    text: 'политикой конфиденциальности',
                    style: GoogleFonts.inter(
                      color: Colours.blueCustom,
                      decoration: TextDecoration.none,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (kDebugMode) {
                          print('Tapped on политикой конфиденциальности');
                        }
                      },
                  ),
                  const TextSpan(
                    text: '.',
                  ),
                ],
              ),
            ),
            AppUtils.kHeight16,
            ElevatedButton(
              onPressed: () {
                if (isNumberFilled) {
                  focusNode.unfocus();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ConfirmCode(phoneNumber)));
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: isNumberFilled
                      ? Colours.blueCustom
                      : Colours.textFieldGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fixedSize: Size(SizeConfig.screenWidth!, 56)),
              child: Text(
                'Продолжить',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: isNumberFilled ? Colors.white : Colours.greyIcon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

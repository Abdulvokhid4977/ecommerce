import 'dart:async';

import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/pages/auth/bloc/opt/otp_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class ConfirmCode extends StatefulWidget {
  final String phoneNumber;

  const ConfirmCode(this.phoneNumber, {super.key});

  @override
  State<ConfirmCode> createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
  final controller = TextEditingController();
  bool isCodeFilled = true;
  bool isCodeCorrect = true;
  bool isTimerExpired = false;
  late Timer _timer;
  int _start = 120;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          isTimerExpired = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String get formattedTime {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  String formatPhoneNumber(String phoneNumber) {
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    return '+998$cleanedNumber';
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 46,
      height: 46,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colours.greyIcon),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colours.blueCustom),
      borderRadius: BorderRadius.circular(12),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
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
                    'Отправили код на номер:  ',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colours.greyIcon,
                    ),
                  ),
                  AppUtils.kHeight10,
                  Text(
                    '+998 ${widget.phoneNumber} ',
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
                  AppUtils.kHeight32,
                  Center(
                    child: Pinput(
                      controller: controller,
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      validator: (s) {
                        if (s == '222222') {
                          setState(() {
                            isCodeCorrect = true;
                          });
                        }
                        return;
                      },
                    ),
                  ),
                  AppUtils.kHeight16,
                  isTimerExpired
                      ? Center(
                          child: TextButton(
                            onPressed: () {
                              context.read<OtpBloc>().add(OtpCodeEvent(
                                  formatPhoneNumber(widget.phoneNumber)));
                              _timer.cancel();
                              startTimer();
                            },
                            child: Text(
                              'Отправить еще раз',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colours.blueCustom,
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child:
                              Text('Повторно отправить через: $formattedTime'),
                        ),
                ],
              ),
            ),
            BlocConsumer<OtpBloc, OtpState>(
              listener: (context, state) {
                if (kDebugMode) {
                  print(state.runtimeType);
                }
                if (state is VerifySuccess) {
                  Navigator.pushReplacementNamed(context, Routes.main);
                  context.read<MainBloc>().add(ChangeTabEvent(2));
                }
                if (state is OtpError) {
                  Navigator.pushReplacementNamed(context, Routes.register);
                }
                if (state is VerifyUnsuccessful) {
                  Fluttertoast.showToast(msg: 'Заново отправьте код');
                }
              },
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: state is VerifyLoading
                      ? _buildLoadingIndicator()
                      : _buildButton(context),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Container(
        key: const ValueKey<String>('loading'),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colours.textFieldGrey,
          borderRadius: BorderRadius.circular(56),
        ),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colours.blueCustom),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      key: const ValueKey<String>('button'),
      onPressed: isCodeFilled
          ? () {
              context.read<OtpBloc>().add(VerifyCodeEvent(
                  formatPhoneNumber(widget.phoneNumber), controller.text));
            }
          : null,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:
            isCodeFilled ? Colours.blueCustom : Colours.textFieldGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fixedSize: Size(SizeConfig.screenWidth!, 56),
      ),
      child: Text(
        'Продолжить',
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: isCodeFilled ? Colors.white : Colours.greyIcon,
        ),
      ),
    );
  }
}

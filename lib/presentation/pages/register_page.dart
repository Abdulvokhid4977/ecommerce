import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isFilled = false;
  int? day = DateTime.now().day;
  int? month = DateTime.now().month;
  int? year = DateTime.now().year;
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var maskFormatter2 = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final RegExp dateRegExp = RegExp(
    r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/([0-9]{4})$',
  );



  final Map<String, Object?> _addingHandler = {
    'name': '',
    'birthDate': '',
    'phoneNumber': '',
  };

  void _submit() {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();
  }
  void _isFilled(){
    if(controller3.text.length==14 && controller2.text.length>10 && controller1.text.isNotEmpty){
      setState(() {
        isFilled=true;
      });
    } else {
      setState(() {
      isFilled=false;
    });}
  }

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    _focusNode3.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(FocusNode focusNode, String hintText,
      {bool isNumber = false, bool isDate = false}) {
    return InputDecoration(
        counterText: '',
        prefixIcon: isNumber
            ? const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  '+998',
                  style: TextStyle(fontSize: 17),
                ),
              )
            : null,
        hintText: hintText,
        filled: true,
        fillColor:
            focusNode.hasFocus ? Colours.textFieldBlue : Colours.textFieldGrey,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colours.blueCustom),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: isDate
            ? IconButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1995),
                    lastDate: DateTime(
                        2024, DateTime.now().month, DateTime.now().day),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        final day = value.day.toString().padLeft(2, '0');
                        final month = value.month.toString().padLeft(2, '0');
                        final year = value.year;
                        controller1.text = '$day/$month/$year';
                      });
                    }
                  });
                },
                icon: const Icon(Icons.date_range_rounded))
            : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colours.blueCustom,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Регистрация',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    AppUtils.kHeight32,
                    const Text('ФИО'),
                    AppUtils.kHeight10,
                    TextFormField(
                      controller: controller2,
                      textCapitalization: TextCapitalization.words,
                      focusNode: _focusNode1,
                      onTapOutside: (i) {
                        _focusNode1.unfocus();
                      },
                      maxLength: 100,
                      cursorColor: Colours.blueCustom,
                      keyboardType: TextInputType.name,
                      decoration: _inputDecoration(_focusNode1, 'Введите ФИО'),
                      validator: (val) {
                        if (val == '') {
                          return 'Не должна быть пустым';
                        }
                        return null;
                      },
                      onChanged: (val){
                        _isFilled();
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focusNode2);

                      },
                      onSaved: (value) {
                        _addingHandler['name'] = value;
                      },
                    ),
                    AppUtils.kHeight32,
                    const Text('Дата рождения'),
                    AppUtils.kHeight10,
                    TextFormField(
                      controller: controller1,
                      focusNode: _focusNode2,
                      onTapOutside: (i) {
                        _focusNode2.unfocus();
                      },
                      inputFormatters: [maskFormatter2],
                      cursorColor: Colours.blueCustom,
                      keyboardType: TextInputType.datetime,
                      decoration: _inputDecoration(
                          _focusNode2, 'Введите дату рождения: дд/мм/гггг',
                          isDate: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a date';
                        } else if (!dateRegExp.hasMatch(value)) {
                          return 'Please enter a valid date in dd/mm/yyyy format';
                        } else {
                          // Parse the date
                          final parts = value.split('/');
                          final int day = int.parse(parts[0]);
                          final int month = int.parse(parts[1]);
                          final int year = int.parse(parts[2]);

                          final DateTime parsedDate = DateTime(year, month, day);
                          final DateTime currentDate = DateTime.now();
                          final DateTime minDate = DateTime(1900, 1, 1);

                          if (parsedDate.isBefore(minDate)) {
                            return 'Date cannot be before 01/01/1900';
                          } else if (parsedDate.isAfter(currentDate)) {
                            return 'Date cannot be in the future';
                          }
                        }
                        return null; // The input is valid
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focusNode3);

                      },
                      onChanged: (val){
                        _isFilled();
                      },
                      onSaved: (value) {
                        _addingHandler['birthDate'] = value;
                      },
                    ),
                    AppUtils.kHeight32,
                    const Text('Номер телефона'),
                    AppUtils.kHeight10,
                    TextFormField(
                      controller: controller3,
                      focusNode: _focusNode3,
                      onTapOutside: (i) {
                        _focusNode3.unfocus();
                      },
                      inputFormatters: [maskFormatter],
                      maxLength: 14,
                      cursorColor: Colours.blueCustom,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration(
                        _focusNode3,
                        '(_ _) _ _ _ - _ _ - _ _',
                        isNumber: true,
                      ),
                      validator: (val) {
                        if (val == null) {
                          return 'Не должна быть пустым';
                        } else if (val.length < 14) {
                          return 'Введите номер телефона полностью';
                        }
                        return null;
                      },
                      onChanged: (val){
                        _isFilled();
                      },
                      onFieldSubmitted: (_) {
                       _focusNode3.unfocus();
                      },
                      onSaved: (value) {
                        _addingHandler['phoneNumber'] = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isFilled ? Colours.blueCustom : Colours.textFieldGrey,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: Size(
                    SizeConfig.screenWidth!, SizeConfig.screenHeight! * 0.06),
              ),
              child: Text(
                'Продолжить',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: isFilled ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

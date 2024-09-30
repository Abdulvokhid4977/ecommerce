import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cached_values.dart';
import 'package:e_commerce/core/services/register_service.dart';
import 'package:e_commerce/presentation/pages/auth/bloc/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPage extends StatefulWidget {
  final bool isRegister;

  const RegisterPage(this.isRegister, {Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String? customerId;
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  bool _isFilled = false;

  final Map<String, String?> _formData = {
    'surname': '',
    'name': '',
    'birthday': '',
    'phone_number': '',
    'gender': '',
  };

  final _phoneFormatter = MaskTextInputFormatter(
      mask: '(##) ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final _dateFormatter = MaskTextInputFormatter(
      mask: '####/##/##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() => _updateFormData(i));
      _focusNodes[i].addListener(() => setState(() {}));
    }
    if (!widget.isRegister) {
      _loadExistingData();
    }
  }

  void _updateFormData(int index) {
    final keys = ['surname', 'name', 'birthday', 'phone_number', 'gender'];
    setState(() {
      _formData[keys[index]] = _controllers[index].text;
      _isFilled = _controllers.every((c) => c.text.isNotEmpty);
    });
  }

  String formatPhoneNumber(String phoneNumber) {
    String cleaned = phoneNumber.replaceAll(RegExp(r'\D'), '').substring(3);

    // Split the remaining digits into groups
    String part1 = cleaned.substring(0, 2);
    String part2 = cleaned.substring(2, 5);
    String part3 = cleaned.substring(5, 7);
    String part4 = cleaned.substring(7);

    // Join the parts with the desired format
    return '($part1) $part2 $part3 $part4';
  }

  Future<void> _loadExistingData() async {
    final customer = await RegisterService().getCartProducts();
    setState(() {
      customerId=customer[0].id;
    });
    if (customer.isNotEmpty) {
      final time = customer[0].birthday;
      String formattedDate = DateFormat('yyyy/MM/dd').format(time);
      setState(() {
        _controllers[0].text = customer[0].surname;
        _controllers[1].text = customer[0].name;
        _controllers[2].text = formattedDate;
        _controllers[3].text = formatPhoneNumber(customer[0].phoneNumber);
        _controllers[4].text = customer[0].gender;
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate() || !context.mounted) return;

    _formKey.currentState!.save();
    final surname = _formData['surname']!;
    final name = _formData['name']!;
    final birthday = _formData['birthday']!;
    final phoneNumber = _formData['phone_number']!;
    final gender = _formData['gender']!;
    final registerBloc = context.read<RegisterBloc>();


    if (widget.isRegister) {
      registerBloc
          .add(PostUserDataEvent(surname, name, birthday, phoneNumber, gender));
    } else {
      if (customerId != null) {
        registerBloc.add(UpdateUserDataEvent(
            surname, name, birthday, customerId!, phoneNumber, gender));
      } else {
      }
    }
  }

  Widget _buildTextFormField({
    required int index,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
    bool isNumber = false,
    bool isDate = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 10),
        TextFormField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          readOnly: readOnly,
          onTap: onTap,
          textCapitalization: TextCapitalization.words,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: _inputDecoration(_focusNodes[index], hint,
              isNumber: isNumber, isDate: isDate),
          validator: validator,
          onFieldSubmitted: (_) => index < 4
              ? FocusScope.of(context).requestFocus(_focusNodes[index + 1])
              : null,
          onSaved: (value) {
            if (index == 3) {
              _formData['phone_number'] = _formatPhoneNumber(value!);
            }
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  InputDecoration _inputDecoration(FocusNode focusNode, String hintText,
      {bool isNumber = false, bool isDate = false}) {
    return InputDecoration(
        counterText: '',
        prefixIcon: isNumber
            ? const Padding(
                padding: EdgeInsets.all(15),
                child: Text('+998', style: TextStyle(fontSize: 17)),
              )
            : null,
        hintText: hintText,
        filled: true,
        fillColor:
            focusNode.hasFocus ? Colours.textFieldBlue : Colours.textFieldGrey,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colours.blueCustom),
            borderRadius: BorderRadius.circular(10)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: isDate
            ? IconButton(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.date_range_rounded))
            : null);
  }

  String _formatPhoneNumber(String phoneNumber) {
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    return '+998$cleanedNumber';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _controllers[2].text =
            '${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: widget.isRegister
            ? const Text('')
            : Text('Настройки профиля',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.black)),
        leading: IconButton(
          splashRadius: 24,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Colours.blueCustom, size: 24),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.isRegister) ...[
                      Text('Регистрация',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700, fontSize: 24)),
                      const SizedBox(height: 32),
                    ],
                    _buildTextFormField(
                      index: 0,
                      label: 'Фамилия',
                      hint: 'Введите Фамилию',
                      validator: (val) =>
                          val!.isEmpty ? 'Не должна быть пустым' : null,
                    ),
                    _buildTextFormField(
                      index: 1,
                      label: 'Имя',
                      hint: 'Введите Имя',
                      validator: (val) =>
                          val!.isEmpty ? 'Не должна быть пустым' : null,
                    ),
                    _buildTextFormField(
                      index: 2,
                      label: 'Дата рождения',
                      hint: 'Введите дату рождения: гггг/мм/дд',
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [_dateFormatter],
                      isDate: true,
                      validator: _validateDate,
                    ),
                    _buildTextFormField(
                      index: 3,
                      label: 'Номер телефона',
                      hint: '(_ _) _ _ _ - _ _ - _ _',
                      keyboardType: TextInputType.number,
                      inputFormatters: [_phoneFormatter],
                      isNumber: true,
                      validator: (val) => (val == null || val.length < 14)
                          ? 'Введите номер телефона полностью'
                          : null,
                    ),
                    _buildTextFormField(
                      index: 4,
                      label: 'Пол',
                      hint: 'Выберите пол',
                      readOnly: true,
                      onTap: _showGenderPicker,
                      validator: (val) =>
                          val!.isEmpty ? 'Не должна быть пустым' : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите дату рождения';
    }
    final dateRegExp = RegExp(r'^\d{4}/\d{2}/\d{2}$');
    if (!dateRegExp.hasMatch(value)) {
      return 'Введите дату рождения: гггг/мм/дд';
    }
    final parts = value.split('/');
    final parsedDate =
        DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
    final currentDate = DateTime.now();
    final minDate = DateTime(1900, 1, 1);

    if (parsedDate.isBefore(minDate)) {
      return 'Date cannot be before 01/01/1900';
    } else if (parsedDate.isAfter(currentDate)) {
      return 'Date cannot be in the future';
    }
    return null;
  }

  Future<void> _showGenderPicker() async {
    final selectedGender = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: ['Мужской', 'Женский']
            .map((gender) => ListTile(
                  title: Text(gender,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400, fontSize: 18)),
                  onTap: () => Navigator.pop(context, gender),
                ))
            .toList(),
      ),
    );
    if (selectedGender != null) {
      setState(() => _controllers[4].text = selectedGender);
    }
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacementNamed(context, Routes.main);
        } else if (state is RegisterError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UpdateProfile) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is RegisterLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ElevatedButton(
          onPressed: _isFilled ? _submit : null,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _isFilled ? Colours.blueCustom : Colours.textFieldGrey,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            minimumSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.06),
          ),
          child: Text(
            widget.isRegister ? 'Зарегистрироваться' : 'Сохранить',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: _isFilled ? Colors.white : Colors.black,
            ),
          ),
        );
      },
    );
  }
}

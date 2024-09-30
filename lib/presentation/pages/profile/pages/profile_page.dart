import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cached_values.dart';
import 'package:e_commerce/core/services/cart_service.dart';
import 'package:e_commerce/core/services/location_service.dart';
import 'package:e_commerce/core/services/register_service.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/data/models/register_model.dart';
import 'package:e_commerce/presentation/pages/auth/pages/register_page.dart';
import 'package:e_commerce/presentation/pages/profile/pages/map_page.dart';
import 'package:e_commerce/presentation/pages/profile/widgets/custom_appbar.dart';
import 'package:e_commerce/presentation/pages/profile/widgets/custom_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Register>? customer;

  @override
  void initState() {
    super.initState();
    _initializeUI();
    _getCustomer();
  }

  void _initializeUI() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ));
    });
  }

  Future<void> _getCustomer() async {
    final result = await RegisterService().getCartProducts();
    setState(() {
      customer = result;
    });
  }

  @override
  void didChangeDependencies() {
    SizeConfig().init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.backgroundGrey,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (customer != null) CustomAppbar(customer!),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildProfileSection(),
                AppUtils.kHeight10,
                _buildLanguageSection(),
                AppUtils.kHeight10,
                _buildLocationSection(),
                AppUtils.kHeight10,
                _buildHelpSection(),
                AppUtils.kHeight10,
                buildSignOutButton(context),
                AppUtils.kHeight10,
                Center(child: _buildVersionInfo()),

              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignOutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          if(customer == null || customer!.isEmpty){
            return ;
          }
          else{
            showDeleteConfirmationDialog(context);
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: const Size(double.infinity, 45),
          backgroundColor: customer == null || customer!.isEmpty ? Colours.greyIcon: Colours.redCustom,
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'Выйти',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  showDeleteConfirmationDialog(BuildContext context) async {
    return PanaraConfirmDialog.showAnimatedGrow(
      context,
      title: "Выход",
      message: "Вы действительно хотите выйти?",
      confirmButtonText: "Выйти",
      cancelButtonText: "Отмена",
      onTapCancel: () {
        Navigator.pop(context);
      },
      onTapConfirm: () async{
        await RegisterService().clearCustomer();
        await CartService().clearCart();
        await LocationService().clearLocation();
        deleteCustomerId();
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, Routes.auth);
        }
      },
      panaraDialogType: PanaraDialogType.error,
      noImage: true,
    );
  }

  Widget _buildProfileSection() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          _buildProfileItem(
              'assets/icons/shopping_bag.svg', 'Мои заказы', () {}),
          _buildProfileItem('assets/icons/percent.svg', 'Мои промокоды',
              _showComingSoonToast),
          _buildProfileItem(
              'assets/icons/bell.svg', 'Уведомления', _showComingSoonToast),
          _buildProfileItem('assets/icons/user.svg', 'Мой профиль',
              () => _navigateTo(const RegisterPage(false))),
          _buildProfileItem('assets/icons/settings.svg', 'Настройки', () {}),
        ],
      ),
    );
  }


  Widget _buildLanguageSection() {
    return CustomContainer(
      'assets/icons/ru.svg',
      'Язык',
      _showLanguageSelectionDialog,
      hasSomething: true,
      something: 'Русский',
    );
  }

  Widget _buildLocationSection() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          CustomContainer(
              'assets/icons/location_icon.svg', 'Город', _showComingSoonToast,
              hasSomething: true, something: 'Ташкент'),
          CustomContainer('assets/icons/map.svg', 'Пункт выдачи на карте',
              () => _navigateTo(const MapPage(showModalOnTap: false))),
        ],
      ),
    );
  }

  Widget _buildHelpSection() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          CustomContainer(
              'assets/icons/faq.svg', 'Справка', _showComingSoonToast),
          CustomContainer('assets/icons/mail.svg', 'Связаться с нами',
              () => _showContactModal(context)),
        ],
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Text(
      'Версия приложения: 1.1.0',
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: Colours.greyIcon,
      ),
    );
  }

  Widget _buildProfileItem(String icon, String title, VoidCallback onTap) {
    return CustomContainer(icon, title, onTap);
  }

  void _showComingSoonToast() {
    Fluttertoast.showToast(
      msg: 'Скоро!',
      backgroundColor: Colours.blueCustom,
    );
  }

  void _navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Future<void> _showLanguageSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text(
            "Выберите Язык",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/ru.svg'),
                  const SizedBox(width: 10),
                  const Text("Русский", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showContactModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Связаться с нами",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialMediaButton('assets/icons/instagram.png',
                      'https://www.instagram.com/abdulvokhid_4977/'),
                  AppUtils.kWidth8,
                  _buildSocialMediaButton('assets/icons/telegram.png',
                      'https://t.me/abdukarimov9900'),
                  AppUtils.kWidth8,
                  _buildSocialMediaButton('assets/icons/whatsapp.png',
                      'https://wa.me/+998974434977'),
                ],
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Отменить",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialMediaButton(String iconPath, String url) {
    return GestureDetector(
      onTap: () => _openSocialMediaUrl(url),
      child: Image.asset(iconPath, height: 45, width: 45),
    );
  }

  Future<void> _openSocialMediaUrl(String url) async {
    final Uri uri = Uri.parse(url);
    String appScheme = url;

    if (url.contains('t.me')) {
      appScheme = 'tg://resolve?domain=${uri.pathSegments.last}';
    } else if (url.contains('instagram.com')) {
      appScheme = 'instagram://user?username=${uri.pathSegments.last}';
    } else if (url.contains('wa.me') || url.contains('whatsapp.com')) {
      appScheme = 'whatsapp://send?phone=${uri.pathSegments.last}';
    }

    final Uri appUri = Uri.parse(appScheme);

    try {
      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error launching URL: $e');
      }
    }
  }
}

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/location_service.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/pages/profile/widgets/custom_appbar.dart';
import 'package:e_commerce/presentation/pages/profile/widgets/custom_container.dart';
import 'package:e_commerce/presentation/pages/profile/widgets/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> showLanguageSelectionDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text(
            "Выберите Язык",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                // Set the app language to Russian
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/ru.svg'),
                  SizedBox(width: 10),
                  Text("Русский", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
  void showContactModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Связаться с нами",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: ()=>openSocialMediaUrl('https://www.instagram.com/abdulvokhid_4977/'),
                    child: Image.asset('assets/icons/instagram.png', height: 45,width: 45,),
                  ),
                  AppUtils.kWidth8,
                  GestureDetector(
                    onTap: ()=>openSocialMediaUrl('https://t.me/abdukarimov9900'),
                    child: Image.asset('assets/icons/telegram.png', height: 45,width: 45, ),
                  ),
                  AppUtils.kWidth8,
                  GestureDetector(
                    onTap: ()=>openSocialMediaUrl('https://wa.me/+998974434977'),
                    child: Image.asset('assets/icons/whatsapp.png', height: 45,width: 45,),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Dismiss the modal
                },
                child: const Text(
                  "Отменить",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> openSocialMediaUrl(String url) async {
    final Uri uri = Uri.parse(url);

    // Determine the app scheme based on the URL
    String appScheme;
    if (url.contains('t.me')) {
      appScheme = 'tg://resolve?domain=${uri.pathSegments.last}';
    } else if (url.contains('instagram.com')) {
      appScheme = 'instagram://user?username=${uri.pathSegments.last}';
    } else if (url.contains('wa.me') || url.contains('whatsapp.com')) {
      appScheme = 'whatsapp://send?phone=${uri.pathSegments.last}';
    } else {
      // If it's not a recognized social media URL, just use the original URL
      appScheme = url;
    }

    final Uri appUri = Uri.parse(appScheme);

    try {
      // Try to launch the app first
      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri, mode: LaunchMode.externalApplication);
      }
      // If the app is not installed, open in web browser
      else if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Handle the error, maybe show a dialog to the user
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ));
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
          const CustomAppbar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      DecoratedBox(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            CustomContainer(
                              'assets/icons/shopping_bag.svg',
                              'Мои заказы',
                              () {},
                            ),
                            CustomContainer(
                              'assets/icons/percent.svg',
                              'Мои промокоды',
                              () {
                                Fluttertoast.showToast(msg: 'Скоро!', backgroundColor: Colours.blueCustom,);
                              },
                            ),
                            CustomContainer(
                              'assets/icons/bell.svg',
                              'Уведомления',
                              () { Fluttertoast.showToast(msg: 'Скоро!', backgroundColor: Colours.blueCustom,);},
                            ),
                            CustomContainer(
                              'assets/icons/user.svg',
                              'Мой профиль',
                              () {},
                            ),
                            CustomContainer(
                              'assets/icons/settings.svg',
                              'Настройки',
                              () {},
                            ),
                          ],
                        ),
                      ),
                      AppUtils.kHeight10,
                      CustomContainer(
                        'assets/icons/ru.svg',
                        'Язык',
                        () async {
                          await showLanguageSelectionDialog(context);
                        },
                        hasSomething: true,
                        something: 'Русский',
                      ),
                      AppUtils.kHeight10,
                      DecoratedBox(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            CustomContainer('assets/icons/location_icon.svg',
                                'Город', () {},
                                hasSomething: true, something: 'Ташкент'),
                            CustomContainer(
                              'assets/icons/map.svg',
                              'Пункт выдачи на карте',
                              () {
                               Navigator.push(context, MaterialPageRoute(builder: (_){
                                 return const MapPage();
                               }),
                               );
                              },
                            ),
                          ],
                        ),
                      ),
                      AppUtils.kHeight10,
                      DecoratedBox(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            CustomContainer(
                              'assets/icons/faq.svg',
                              'Справка',
                              () { Fluttertoast.showToast(msg: 'Скоро!', backgroundColor: Colours.blueCustom,);},
                            ),
                            CustomContainer(
                              'assets/icons/mail.svg',
                              'Связаться с нами',
                              () {showContactModal(context);},
                            ),
                          ],
                        ),
                      ),
                      AppUtils.kHeight10,
                      Text(
                        'Версия приложения: 1.28.0 (8290)',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colours.greyIcon,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

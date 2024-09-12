import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map> profileSettings = [
    {'asset': 'assets/icons/shopping_bag.svg', 'label': 'Мои заказы'},
    {'asset': 'assets/icons/feedback_emoji.svg', 'label': 'Мои отзывы'},
    {'asset': 'assets/icons/card.svg', 'label': 'Рассрочка Ummerce Nasiya'},
  ];

  final List<Map> profileSettings2 = [
    {'asset': 'assets/icons/percent.svg', 'label': 'Мои промокоды'},
    {'asset': 'assets/icons/message.svg', 'label': 'Мои чаты'},
    {'asset': 'assets/icons/bell.svg', 'label': 'Уведомления'},
    {'asset': 'assets/icons/user.svg', 'label': 'Мой профиль'},
    {'asset': 'assets/icons/settings.svg', 'label': 'Настройки'},
  ];
  final List<Map> profileSettings4 = [
    {'asset': 'assets/icons/faq.svg', 'label': 'Справка'},
    {'asset': 'assets/icons/mail.svg', 'label': 'Связаться с нами'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
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
          SliverAppBar(
            backgroundColor: Colours.blueCustom,
            automaticallyImplyLeading: false,
            expandedHeight: SizeConfig.screenHeight! * 0.3,
            floating: false,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // Calculate the percentage of the app bar's expansion
                double percentage = (constraints.maxHeight - kToolbarHeight) /
                    (SizeConfig.screenHeight! * 0.3 - kToolbarHeight);

                double avatarRadius = 35.0 * percentage.clamp(0.6, 1.0);

                return FlexibleSpaceBar(
                  centerTitle: true,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "assets/images/profile_background.jpg",
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        width: SizeConfig.screenWidth,
                        top: SizeConfig.statusBar! + 10,
                        child: Text(
                          "Личный кабинет",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  titlePadding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: const AssetImage(
                          "assets/images/profile.jpg",
                        ),
                      ),
                      AppUtils.kWidth12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Abdulvokhid A.",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            Text(
                              "+998 97 443 49 77",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _customContainer(profileSettings),
                      AppUtils.kHeight10,
                      _customContainer(profileSettings2),
                      AppUtils.kHeight10,
                      _customContainer(
                        [
                          {'asset': 'assets/icons/ru.svg', 'label': 'Язык'},
                        ],
                        hasSomething: true,
                        something: 'Русский',
                      ),
                      AppUtils.kHeight10,
                      _customContainer([
                        {
                          'asset': 'assets/icons/location_icon.svg',
                          'label': 'Город'
                        },
                      ], hasSomething: true, something: 'Ташкент'),
                      AppUtils.kHeight10,
                      _customContainer(
                        [
                          {
                            'asset': 'assets/icons/map.svg',
                            'label': 'Пункт выдачи на карте'
                          },
                        ],
                      ),
                      AppUtils.kHeight10,
                      _customContainer(profileSettings4),
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

  Widget _customContainer(List<Map> list,
      {bool hasSomething = false, String? something}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (ctx, i) {
          return const Divider();
        },
        itemCount: list.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            leading: SvgPicture.asset(
              list[i]['asset'],
            ),
            title: Text(list[i]['label']),
            trailing: hasSomething
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        something!,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colours.greyIcon,
                        ),
                      ),
                      AppUtils.kWidth8,
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  )
                : const Icon(Icons.keyboard_arrow_right),
          );
        },
      ),
    );
  }
}

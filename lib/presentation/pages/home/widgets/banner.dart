import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../bloc/main/main_bloc.dart';

class BannerWidget extends StatefulWidget {
  final MainLoaded state;
  final PageController controller;
  const BannerWidget(this.state,this.controller,{super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _currentPage=0;
  Timer? timer;


  void _startTimer(int bannerLength) {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < bannerLength - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (widget.controller.hasClients) {
        widget.controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();

  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      _startTimer(widget.state.banners.banner.length);
    }
    return SizedBox(
      height: SizeConfig.screenHeight! * 0.25,
      child: PageView(
        controller: widget.controller,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: List.generate(
            widget.state.banners.banner.length, (i) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 8,
            ),
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(8),
              child: Image.network(
                widget.state.banners.banner[i].bannerImage,
                fit: BoxFit.fill,
              ),
            ),
          );
        }),
      ),
    );
  }
}

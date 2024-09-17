import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../bloc/main/main_bloc.dart';

class BannerWidget extends StatefulWidget {
  final MainLoaded state;
  final PageController controller;
  const BannerWidget(this.state, this.controller, {super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _currentPage = 0;
  Timer? _timer;

  void _startTimer(int bannerLength) {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (widget.controller.hasClients) {
        widget.controller.animateToPage(
          (_currentPage + 1) % bannerLength,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPage = (_currentPage + 1) % bannerLength;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTimer(widget.state.banners.banner.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          widget.state.banners.banner.length,
              (i) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.state.banners.banner[i].bannerImage,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
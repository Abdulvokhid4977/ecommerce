// import 'package:e_commerce/core/constants/constants.dart';
// import 'package:e_commerce/core/utils/utils.dart';
// import 'package:e_commerce/data/models/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class ImagePageView extends StatefulWidget {
//   final List<String> images;
//   final List<ProductColor> colorOptions;
//
//   const ImagePageView({
//     required this.images,
//     required this.colorOptions,
//     super.key,
//   });
//
//   @override
//   State<ImagePageView> createState() => _ImagePageViewState();
// }
//
// class _ImagePageViewState extends State<ImagePageView> {
//   final PageController _controller = PageController();
//   int _selectedColorIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AppUtils.kHeight32,
//         SizedBox(
//           height: SizeConfig.screenHeight! * 0.49,
//           child: PageView.builder(
//             controller: _controller,
//             onPageChanged: (i) {
//               // Optional: handle page change if needed
//             },
//             itemCount: widget.images.length,
//             itemBuilder: (ctx, i) {
//               return Image.network(
//                 widget.images[i],
//                 height: SizeConfig.screenHeight! * 0.49,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               );
//             },
//           ),
//         ),
//         SizedBox(
//           height: SizeConfig.statusBar,
//         ),
//         SmoothPageIndicator(
//           controller: _controller,
//           count: widget.images.length, // Adjust to the number of images
//           effect: SlideEffect(
//             dotWidth: 8,
//             dotHeight: 8,
//             activeDotColor: Colours.blueCustom,
//           ),
//         ),
//         AppUtils.kHeight16,
//
//         ColorSelectionWidget(
//           colorOptions: widget.colorOptions,
//           onColorSelected: (index) {
//             setState(() {
//               _selectedColorIndex = index;
//               _controller
//                   .jumpToPage(index); // Jump to the corresponding image page
//             });
//           },
//         ),
//       ],
//     );
//   }
// }
//
// class ColorSelectionWidget extends StatefulWidget {
//   final List<ProductColor> colorOptions;
//   final ValueChanged<int> onColorSelected;
//
//   const ColorSelectionWidget({
//     required this.colorOptions,
//     required this.onColorSelected,
//     super.key,
//   });
//
//   @override
//   State<ColorSelectionWidget> createState() => _ColorSelectionWidgetState();
// }
//
// class _ColorSelectionWidgetState extends State<ColorSelectionWidget> {
//   int _selectedColorIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(
//           Radius.circular(8),
//         ),
//         color: Colors.white,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 'Цвет: ',
//                 style: GoogleFonts.inter(
//                   fontWeight: FontWeight.w500,
//                   color: Colours.greyIcon,
//                   fontSize: 18,
//                 ),
//               ),
//               Text(
//                 widget.colorOptions[_selectedColorIndex].colorName,
//                 style: GoogleFonts.inter(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           SizedBox(
//             width: SizeConfig.screenWidth,
//             height: SizeConfig.screenHeight! * 0.12,
//             child: ListView.separated(
//               separatorBuilder: (ctx, i) => AppUtils.kWidth12,
//               scrollDirection: Axis.horizontal,
//               itemCount: widget.colorOptions.length,
//               itemBuilder: (ctx, i) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedColorIndex = i;
//                       widget.onColorSelected(
//                           i); // Notify parent widget of selection
//                     });
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: _selectedColorIndex == i
//                             ? Colours.blueCustom
//                             : Colors.transparent,
//                         width: 2,
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colours.backgroundGrey,
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         widget.colorOptions[i].colorUrl,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

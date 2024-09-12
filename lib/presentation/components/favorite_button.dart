// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../data/models/product_model.dart';
// import '../bloc/favorite/favorite_bloc.dart';
//
//
// class FavoriteToggleButton extends StatefulWidget {
//   final ProductElement productElement;
//
//   const FavoriteToggleButton({super.key, required this.productElement});
//
//   @override
//   State<FavoriteToggleButton> createState() => _FavoriteToggleButtonState();
// }
//
// class _FavoriteToggleButtonState extends State<FavoriteToggleButton> {
//   bool isFavorite = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<FavoriteBloc, FavoriteState>(
//       listener: (context, state) {
//         if (state is AddState || state is DeleteState) {
//           setState(() {
//             isFavorite = state is AddState; // Update based on state
//           });
//         } else if (state is FavoriteError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error: ${state.message}')),
//           );
//         }
//       },
//       builder: (context, state) {
//         return IconButton(
//           splashColor: Colors.transparent,
//           onPressed: () {
//             final newFavoriteStatus = !isFavorite;
//
//             // Triggering favorite toggle
//             if (newFavoriteStatus) {
//               context.read<FavoriteBloc>().add(
//                 AddEvent(widget.productElement, newFavoriteStatus),
//               );
//             } else {
//               context.read<FavoriteBloc>().add(
//                 DeleteEvent(newFavoriteStatus,widget.productElement),
//               );
//             }
//           },
//           icon: Icon(
//             isFavorite ? Icons.favorite : Icons.favorite_border,
//             color: isFavorite ? Colors.red : Colors.grey,
//           ),
//         );
//       },
//     );
//   }
// }

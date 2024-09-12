import 'package:e_commerce/data/models/category_model.dart';
import 'package:e_commerce/presentation/bloc/search/search_bloc.dart';
import 'package:e_commerce/presentation/pages/search/grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/product_model.dart';

class SearchList extends StatefulWidget {
  final List<ProductElement> product;
  final List<CategoryElement> category;
  final TextEditingController controller;
  final FocusNode focus;

  const SearchList(this.product, this.category, this.controller, this.focus,
      {super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.controller.text.isNotEmpty) ...[
            const Text('Tовары'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.product.length > 3
                  ? widget.product.getRange(0, 3).length
                  : widget.product.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.search),
                  title: Text(widget.product[index].name),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                GridViewWidget(widget.product, index)));
                  },
                );
              },
            ),
            const Divider(),
            const Text('Категории'),
            Expanded(
              child: ListView.builder(
                itemCount: widget.category.length > 3
                    ? widget.category.getRange(0, 3).length
                    : widget.category.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Text(
                        widget.category[index].name.substring(0, 2),
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    title: Text(widget.category[index].name),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      context.read<SearchBloc>().add(FetchSearchDataEvent(
                          widget.category[index].id, false));
                      widget.focus.unfocus();
                      widget.controller.text=widget.category[index].name;

                    },
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

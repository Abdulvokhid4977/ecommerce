import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cached_values.dart';
import 'package:e_commerce/data/models/category_model.dart';
import 'package:e_commerce/presentation/pages/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/product_model.dart';

class SearchList extends StatefulWidget {
  final List<ProductElement> product;
  final List<CategoryElement> category;
  final TextEditingController controller;

  const SearchList(this.product, this.category, this.controller, {super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<String> _recentSearches = [];

  void _loadRecentSearches() async {
    List<String> recentSearches =
        await SearchHistoryManager.getLastSearchedProducts();
    setState(() {
      _recentSearches = recentSearches;
    });
  }

  Future<void> _delete(String recent) async {
    await SearchHistoryManager.deleteSearchString(recent);
  }

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.controller.text.isNotEmpty
            ? [
                const Text('Недавно искали'),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _recentSearches.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.access_time_rounded,
                          color: Colours.greyIcon),
                      title: Text(_recentSearches[index]),
                      trailing: IconButton(
                        onPressed: () async {
                          await _delete(_recentSearches[index]);
                          setState(() {
                            _recentSearches.removeAt(index);
                          });
                        },
                        icon: Icon(Icons.cancel, color: Colours.greyIcon, size: 24,),
                      ),
                      onTap: () {
                        SearchHistoryManager.saveSearchedProduct(
                            _recentSearches[index]);
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (_) =>
                        //           GridViewWidget(),
                        //     ),
                        //   );
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
                            SearchHistoryManager.saveSearchedProduct(
                                widget.product[index].name);
                            context.read<SearchBloc>().add(FetchSearchDataEvent(
                                widget.category[index].id, false));
                            widget.controller.text =
                                widget.category[index].name;
                          });
                    },
                  ),
                ),
              ]
            : [
                _recentSearches.isNotEmpty
                    ? const Text('Недавно искали')
                    : const SizedBox(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _recentSearches.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.access_time_rounded,
                          color: Colours.greyIcon),
                      title: Text(_recentSearches[index]),
                      trailing: IconButton(
                        onPressed: () async {
                          // Call _delete and then update the UI
                          await _delete(_recentSearches[index]);
                          setState(() {
                            _recentSearches.removeAt(index); // Update the list
                          });
                        },
                        icon: Icon(Icons.cancel, color: Colours.greyIcon),
                      ),
                      onTap: () {
                        SearchHistoryManager.saveSearchedProduct(
                            _recentSearches[index]);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) =>
                        //         GridViewWidget(widget.product, index),
                        //   ),
                        // );
                      },
                    );
                  },
                ),
              ],
      ),
    );
  }
}
